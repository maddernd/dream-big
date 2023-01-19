import { Component, ViewChild, ElementRef, AfterViewInit, Input } from '@angular/core';
import Konva from 'konva';
import { Category, Point, Polygon, StarCoord } from './types';
@Component({
    selector: 'app-konv-star',
    templateUrl: './konv-star.component.html'
})
export class KonvStarComponent implements AfterViewInit {
    // @ViewChild('canvas') canvas: ElementRef<HTMLCanvasElement> = {} as ElementRef<HTMLCanvasElement>;

    private stage: Konva.Stage; // konva.js root stage
    private starLayer: Konva.Layer;
    private polyLayer: Konva.Layer;
    private textLayer: Konva.Layer;
    @Input() categories!: Array<Category>;
    @Input() starSize!: number;
    @Input() centrePoint!: Point;
    @Input() rotation!: number;
    @Input() outerRatio!: number;
    @Input() innerRatio!: number;
    @Input() numSpikes!: number;

    @Input() minScore!: number;
    @Input() polygonFillColour!: string;

    catPolygons: Array<Polygon> = [];
    collidedPolygon: Polygon = {} as Polygon;
    polygonCollision: boolean = false;

    starCoords: Array<StarCoord> = [];

    starColour: string = "#EAEEF0"
    textColour: string = 'black';
    textFont: string = 'Arial'
    textSize: number = 25;

    ngAfterViewInit(): void {
        this.stage = new Konva.Stage({
            container: 'container',   // id of container <div>
            width: 1000,
            height: 1000,
        });
        this.starLayer = new Konva.Layer();
        this.polyLayer = new Konva.Layer();
        this.textLayer = new Konva.Layer();

        this.starCoords = this.getStarCoords(this.numSpikes);

        this.stage.add(this.starLayer);
        this.stage.add(this.polyLayer);
        this.stage.add(this.textLayer);

        setTimeout(() => {
            this.drawScene(true);
        }, 0);
    }

    public drawScene(hasChanged: boolean) {
        // draw the star to the canvas and retrieve the points for all inner and outer spikes points
        // check if the category polygons should be recreated
        if (hasChanged || this.catPolygons.length == 0) {
            this.catPolygons = this.getCatPolygons();
            this.starCoords = this.getStarCoords(this.numSpikes);
        }

        this.addPolyToLayer();
        this.addSpikesToLayer();
        this.starLayer.moveToTop();
    }

    /**
     * 
     * @param score 
     * @returns score scaled to ensure a minimum inner star size
     */
    getScaledMinScore(score: number) {
        let newScore = this.minScore - ((score / 100) * this.minScore)
        return score + newScore;
    }

    /**
     * Calculates the points for the inner spikes of the inner star for each category.
     * Takes into account the scores and properties of the categories, as well as the previous and next categories.
     * Scales the scores to fit within the size of the inner star, and determines the maximum edge length for each inner spike.
     * @returns an array of Polygon objects containing the calculated points for each category
     */
    private getCatPolygons() {
        let catPolygons: Polygon[] = [];
        var prevCategory = this.categories[this.categories.length - 1];

        for (var i = 0; i < this.categories.length; i++) {
            /**
             * it needs to calculate where to place the inner spikes of the inner star.
             * to do this, it will draw a line from the centre of the star to an inner spike of the outer star
             * the inner star's inner spike point will be a point along this line.
             * it then scales category score to ensure it can never be larger than the outer star's spike length
             * the scaled score can then be used to find the point along a line which is scaled score distance away from the centre point of the star
             * 
             * also need to inspect the previous and next categories, as this polygon will share an inner spike with each of them.
             * choose the inner spike locations by calculating the scores of the previous, current and next category.
             * determine whether to use this polygon, the previous, or the next one's inner spike length by using the maximum value
             * 
             * then find the points along the lines towards the outer star's inner spikes. do this for the left and right inner spikes.
             */
            const nextCategory = i == this.categories.length - 1 ? this.categories[0] : this.categories[i + 1];
            const starCoord = this.starCoords[i];

            // use this.getScore to scale the score to give the inner star a minimum size
            var score = this.getScaledMinScore(this.categories[i].score)
            // the previous and next scores are retrieved to allow for the resizing of polygon edges
            var prevScore = this.getScaledMinScore(prevCategory.score);
            var nextScore = this.getScaledMinScore(nextCategory.score);

            // all scores must be scaled to fit within the star
            const scaledOuterScore = ((this.starSize * this.outerRatio) / 100) * score;
            const scaledInnerScore = (this.starSize * this.innerRatio / 100) * score;
            const scaledPrevInnerScore = (this.starSize * this.innerRatio / 100) * prevScore;
            const scaledNextInnerScore = (this.starSize * this.innerRatio / 100) * nextScore;

            var outerSpikeLength = Math.min(scaledOuterScore, this.starSize * this.outerRatio);

            // find all the possible inner spike lengths
            var innerSpikeLength = Math.min(scaledInnerScore, this.starSize * this.innerRatio);
            var prevInnerSpikeLength = Math.min(scaledPrevInnerScore, this.starSize * this.innerRatio);
            var nextInnerSpikeLength = Math.min(scaledNextInnerScore, this.starSize * this.innerRatio);

            let maxEdgeLengthL, maxEdgeLengthR;
            // determine the max length between this polygon and its neighbours
            maxEdgeLengthL = Math.max(prevInnerSpikeLength, innerSpikeLength);
            maxEdgeLengthR = Math.max(nextInnerSpikeLength, innerSpikeLength)

            // calculate the points on the corresponding inner spike lines, using the maximum edge length for each inner spike
            const edgeL = calculateLinePoint(this.centrePoint.x, this.centrePoint.y, starCoord.edgeL.x, starCoord.edgeL.y, maxEdgeLengthL);
            const edgeR = calculateLinePoint(this.centrePoint.x, this.centrePoint.y, starCoord.edgeR.x, starCoord.edgeR.y, maxEdgeLengthR);
            const scoreXY = calculateLinePoint(this.centrePoint.x, this.centrePoint.y, starCoord.spike.x, starCoord.spike.y, outerSpikeLength);

            catPolygons.push({
                points: {
                    spike: scoreXY,
                    edgeR: edgeR,
                    edgeL: edgeL,
                    centre: this.centrePoint,
                },
                highlight: false,
                category: this.categories[i],
                path: {},
            });
            prevCategory = this.categories[i];
        }
        return catPolygons;
    }
    
    private addPolyToLayer() {
        this.polyLayer.removeChildren();
        const text = new Konva.Text({
            x: 10,
            y: 20,
            text: '',
            fontSize: this.textSize,
            fontFamily: this.textFont,
            fill: this.textColour,
            visible: false,
        });
        this.textLayer.add(text);

        for (let i = 0; i < this.catPolygons.length; i++) {
            const poly = this.catPolygons[i];

            const polygon = new Konva.Shape({
                x: this.centrePoint.x,
                y: this.centrePoint.y,
                fill: this.polygonFillColour,
                stroke: 'black',
                strokeWidth: 1,
                sceneFunc(context, shape) {
                    context.beginPath();
                    context.moveTo(poly.points.centre.x, poly.points.centre.y);
                    context.lineTo(poly.points.edgeL.x, poly.points.edgeL.y);
                    context.lineTo(poly.points.spike.x, poly.points.spike.y);
                    context.lineTo(poly.points.edgeR.x, poly.points.edgeR.y);
                    context.lineTo(poly.points.centre.x, poly.points.centre.y);
                    context.closePath();
                    context.fillStrokeShape(shape);
                },
            });

            this.addPolygonListeners(polygon, poly, text);

            this.polyLayer.add(polygon);
        }
    }

    private addPolygonListeners(polygon: Konva.Shape, poly: Polygon, text: Konva.Text) {
        polygon.on('pointerenter', () => {
            this.onPolygonEnter(polygon, poly, text);
        });
        polygon.on('pointerleave', () => {
            this.onPolygonLeave(polygon, text);
        });
    }

    private onPolygonEnter(polygon: Konva.Shape, poly: Polygon, text: Konva.Text) {
        polygon.stroke(poly.category.colour);
        polygon.strokeWidth(3);
        polygon.moveToTop();
        text.text(poly.category.name);
        text.visible(true);
    }

    private onPolygonLeave(polygon: Konva.Shape, text: Konva.Text) {
        polygon.stroke('black');
        polygon.strokeWidth(1);
        polygon.moveToBottom()
        text.visible(false);
    }
    // private addPolyToLayer() {
    //     this.polyLayer.destroyChildren();
    //     for (var i = 0; i < this.catPolygons.length; i++) {
    //         const poly = this.catPolygons[i];

    //         var polygon = new Konva.Shape({
    //             x: this.centrePoint.x,
    //             y: this.centrePoint.y,
    //             fill: this.polygonFillColour,
    //             stroke: 'black',
    //             strokeWidth: 1,
    //             // a Konva.Canvas renderer is passed into the sceneFunc function
    //             sceneFunc(context, shape) {
    //                 context.beginPath();
    //                 context.moveTo(poly.points.centre.x, poly.points.centre.y);
    //                 context.lineTo(poly.points.edgeL.x, poly.points.edgeL.y);
    //                 context.lineTo(poly.points.spike.x, poly.points.spike.y);
    //                 context.lineTo(poly.points.edgeR.x, poly.points.edgeR.y);
    //                 context.lineTo(poly.points.centre.x, poly.points.centre.y);
    //                 context.closePath();
    //                 // Konva specific method
    //                 context.fillStrokeShape(shape);
    //             }
    //         });
    //         this.textLayer.destroyChildren();

    //         var text = new Konva.Text({
    //             x: 10,
    //             y: 20,
    //             text: '',
    //             fontSize: this.textSize,
    //             fontFamily: this.textFont,
    //             fill: this.textColour
    //         });

    //         polygon.on('pointerenter', function (evt) {
    //             this.setAttr('stroke', poly.category.colour);
    //             this.setAttr('StrokeWidth', 3);
    //             this.moveToTop();
    //             text.setAttr('text', poly.category.name);
    //         });
    //         polygon.on('pointerleave', function () {
    //             this.setAttr('stroke', 'black');
    //             this.setAttr('StrokeWidth', 1);
    //             text.setAttr('text', '');
    //         });
    //         this.polyLayer.add(polygon);
    //         this.textLayer.add(text);
    //     }
    // }

    private addSpikesToLayer() {
        this.starLayer.destroyChildren();
        for (var i = 0; i < this.starCoords.length; i++) {
            const starCoord = this.starCoords[i];

            var catSpike = new Konva.Shape({
                x: this.centrePoint.x,
                y: this.centrePoint.y,
                stroke: this.categories[i].colour,
                strokeWidth: 5,
                sceneFunc: function (context, shape) {
                    context.beginPath();
                    context.moveTo(starCoord.edgeR.x, starCoord.edgeR.y)
                    context.lineTo(starCoord.spike.x, starCoord.spike.y)
                    context.lineTo(starCoord.edgeL.x, starCoord.edgeL.y)
                    context.strokeShape(shape);
                }
            });
            this.starLayer.add(catSpike);
        }
    }

    private getStarCoords(spikes: number) {
        var outerRadius = this.starSize * this.outerRatio;
        var innerRadius = this.starSize * this.innerRatio;

        var rotationRadians = this.rotation * Math.PI / 180;
        var rot = (Math.PI / 2 * 3) + rotationRadians;
        var step = Math.PI / spikes;

        var x = this.centrePoint.x + Math.cos(rot) * outerRadius;
        var y = this.centrePoint.y + Math.sin(rot) * outerRadius;

        var prevEdge = {
            x: this.centrePoint.x + Math.cos(rot + (step * (spikes * 2 - 1))) * innerRadius,
            y: this.centrePoint.y + Math.sin(rot + (step * (spikes * 2 - 1))) * innerRadius
        };

        const starCoords: StarCoord[] = [];

        for (var i = 0; i < spikes; i++) {
            let starCoord: StarCoord = {
                spike: { x: 0, y: 0 },
                edgeR: { x: 0, y: 0 },
                edgeL: prevEdge,
            };

            x = this.centrePoint.x + Math.cos(rot) * outerRadius;
            y = this.centrePoint.y + Math.sin(rot) * outerRadius;

            starCoord.spike.x = x;
            starCoord.spike.y = y;

            rot += step

            x = this.centrePoint.x + Math.cos(rot) * innerRadius;
            y = this.centrePoint.y + Math.sin(rot) * innerRadius;

            starCoord.edgeR.x = x;
            starCoord.edgeR.y = y;
            starCoords.push(starCoord);

            rot += step
            prevEdge = { x, y } as Point
        }
        return starCoords;
    }

    private getStar(spikes: number): Konva.Shape {
        var outerRadius = this.starSize * this.outerRatio;
        var innerRadius = this.starSize * this.innerRatio;

        var rotationRadians = this.rotation * Math.PI / 180;
        var rot = (Math.PI / 2 * 3) + rotationRadians;
        var step = Math.PI / spikes;

        const starPoints: Point[] = [];

        var x = this.centrePoint.x + Math.cos(rot) * outerRadius;
        var y = this.centrePoint.y + Math.sin(rot) * outerRadius;

        var prevEdge = {
            x: this.centrePoint.x + Math.cos(rot + (step * (spikes * 2 - 1))) * innerRadius,
            y: this.centrePoint.y + Math.sin(rot + (step * (spikes * 2 - 1))) * innerRadius
        };

        const starCoords: StarCoord[] = [];

        for (var i = 0; i < spikes; i++) {
            let starCoord: StarCoord = {
                spike: { x: 0, y: 0 },
                edgeR: { x: 0, y: 0 },
                edgeL: { x: 0, y: 0 },
            };

            x = this.centrePoint.x + Math.cos(rot) * outerRadius;
            y = this.centrePoint.y + Math.sin(rot) * outerRadius;
            starCoord.spike.x = x;
            starCoord.spike.y = y;
            starPoints.push({ x, y });

            rot += step

            x = this.centrePoint.x + Math.cos(rot) * innerRadius;
            y = this.centrePoint.y + Math.sin(rot) * innerRadius;

            starCoord.edgeR.x = x;
            starCoord.edgeR.y = y;
            starCoord.edgeL = prevEdge;
            starPoints.push({ x, y });
            rot += step

            starCoords.push(starCoord);
            prevEdge = { x, y } as Point
        }
        this.starCoords = starCoords;
        var konvStar = new Konva.Shape({
            x: this.centrePoint.x,
            y: this.centrePoint.y,
            stroke: 'black',
            strokeWidth: 2,
            sceneFunc: function (context, shape) {
                context.beginPath();
                context.moveTo(starPoints[0].x, starPoints[0].y)
                for (let i = 1; i < starPoints.length; i++) {
                    context.lineTo(starPoints[i].x, starPoints[i].y);
                }
                context.closePath();
                context.fillStrokeShape(shape);
            }
        });

        return konvStar;
    }

}

/**
 * Calculates a point along a line given two endpoints of the line and a distance from the first endpoint.
 * @param x1 - The x-coordinate of the first endpoint of the line.
 * @param y1 - The y-coordinate of the first endpoint of the line.
 * @param x2 - The x-coordinate of the second endpoint of the line.
 * @param y2 - The y-coordinate of the second endpoint of the line.
 * @param distance - The distance from the first endpoint to the desired point.
 * @returns An object with the x and y coordinates of the point.
 */
function calculateLinePoint(x1: number, y1: number, x2: number, y2: number, distance: number) {
    var vx = x2 - x1;
    var vy = y2 - y1;
    var mag = Math.sqrt(vx * vx + vy * vy);
    vx /= mag;
    vy /= mag;
    var px = x1 + vx * (distance);
    var py = y1 + vy * (distance);
    return { x: px, y: py }
}