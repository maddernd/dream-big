import { Component, ViewChild, ElementRef, AfterViewInit } from '@angular/core';

import { getAngle, getBackgroundStars, getCatPolygons, getCirclePoint, getDistance, getRandomColourCode, getStarData, randInt } from 'src/app/helpers/canvas';
import { BgStar, Polygon, StarData, Category, StarCoord, TextData, Goal, Section } from 'src/app/helpers/types';
import { Point, CircleData, Planet, SolarSystem } from 'src/app/helpers/types';
import Konva from 'konva';
import { Dialog, DialogRef, DIALOG_DATA } from '@angular/cdk/dialog';
import { CIRCLE_OPACITY, CIRCLE_STROKE_COLOUR, CIRCLE_STROKE_WIDTH, HIGHLIGHT_CIRCLE_STROKE_COLOUR, HIGHLIGHT_CIRCLE_STROKE_WIDTH, HIGHLIGHT_ORBIT_CIRCLE_COLOUR, HIGHLIGHT_ORBIT_CIRCLE_WIDTH, NUM_BG_STARS, ORBIT_CIRCLE_STROKE_COLOUR, ORBIT_CIRCLE_STROKE_WIDTH, SELECT_CIRCLE_OPACITY, SELECT_CIRCLE_STROKE_COLOUR, SELECT_CIRCLE_STROKE_WIDTH } from './constants';
import { SectionDialogComponent } from './section-dialog.component';
@Component({
    selector: 'app-solar-system',
    templateUrl: './solar-system.component.html',
    styleUrls: ['./solar-system.component.scss']

})
export class SolarSystemComponent implements AfterViewInit {
    constructor(public dialog: Dialog) { }

    openDialog(section: Section): void {
        const dialogRef = this.dialog.open<string>(SectionDialogComponent, {
            data: section
        });
        // can add an image to the dialog card using this
        // const wedgeImg = document.getElementById('dialog-image');
        // wedgeImg.setAttribute('src', section.wedge.src);
        dialogRef.closed.subscribe(result => {
            console.log('The dialog was closed', result);
        });
    }
    // @Input() loadedStarSystems!: any[];

    private stage: Konva.Stage;
    private bgLayer: Konva.Layer;
    private planetLayer: Konva.Layer;
    private starLayer: Konva.Layer;
    private sectionLayer: Konva.Layer;
    private bgRect: Konva.Rect;
    private planetText: Konva.Text;
    private planetList: Planet[] = [];
    private sectionList: Section[] = [];
    private bgStarList: BgStar[] = [];
    private viewPlanet: Planet = {} as Planet;
    private isSolarSystemView: boolean = true;

    private orbitAnimation: Konva.Animation;
    private _viewSystemZoom: number = 3;
    private _addOrbitAngle: number = 60;

    setCategories: Array<Category> = [
        {
            name: "Experience",
            score: randInt(0, 100),
            colour: "yellow",
            // colour: "#74DB83",
        },
        {
            name: "Knowledge",
            score: randInt(0, 100),
            colour: "red",
            // colour: "#62D6EA",
        },
        {
            name: "Employability",
            score: randInt(0, 100),
            colour: "green",
            // colour: "#EA7662",
        },
        {
            name: "Readiness",
            score: randInt(0, 100),
            colour: "blue",
            // colour: "#DB74CD",
        },
        {
            name: "Networking",
            score: randInt(0, 100),
            colour: "purple",
            // colour: "#F3EA6D",
        },
    ]

    private catPolygons: Polygon[] = [];
    private starData: StarData = {} as StarData;



    ngAfterViewInit(): void {
        // initialise the main konvajs stage object
        this.stage = new Konva.Stage({
            container: 'container',   // id of container <div>
            width: window.document.getElementById('container').clientWidth,
            height: window.document.getElementById('container').clientHeight,
        });
        // initialize each layer that will be required
        this.bgLayer = new Konva.Layer();

        this.planetLayer = new Konva.Layer();
        this.starLayer = new Konva.Layer();
        this.sectionLayer = new Konva.Layer();

        // generate the background of the stage by randomly placing different white circles
        this.bgStarList = getBackgroundStars(NUM_BG_STARS, window.document.getElementById('container').clientWidth, window.document.getElementById('container').clientWidth);
        this.addBgStarsToLayer();

        // randomly generate a random number of planets to be displayed
        // assign a random image from /assets/Planets/ to each planet
        this.planetList = this.getPlanetList();

        this.stage.add(this.bgLayer);


        setTimeout(() => {
            // draw the solar system, including the journey star in the centre
            // this has been separated so the user can switch between viewing their solar system and viewing an individual planet
            this.startViewingSolarSystem();
        }, 0);
    }

    private startViewingSolarSystem() {
        this.planetLayer.hide();
        this.starLayer.hide();
        this.sectionLayer.hide();

        this.bgRect.removeEventListener('click');
        // unselect any clicked planets when the background is clicked
        this.bgRect.on('click', (evt) => {
            this.planetText.text('');
            for (let i = 0; i < this.planetList.length; i++) {
                this.planetList[i].collided = false;
                this.planetList[i].clicked = false;
                this.planetList[i].kplanetCircle.setAttrs({
                    'stroke': CIRCLE_STROKE_COLOUR,
                    'strokeWidth': CIRCLE_STROKE_WIDTH
                });
            }
        });
        // remove the section layer from the stage
        this.sectionLayer.destroy();
        this.stage.add(this.planetLayer);
        this.stage.add(this.starLayer);

        // add planets from this.planetList to this.planetLayer
        // start planets watching for mouse events and create the orbiting animation
        this.addPlanetsToLayer();
        // start the animation
        this.orbitAnimation.start();
        // generate and retrieve the data for a star
        this.starData = getStarData(
            this.setCategories,
            this.getCanvasMidPoint(),
            10
        );
        // generate the polygons that make up the inner star
        // this uses the scores from this.starData.
        this.catPolygons = getCatPolygons(this.starData);
        var starGroup = this.getStarGroup(this.starData.starCoords, { x: 0, y: 0 }, 'gold');
        this.starLayer.add(starGroup);
        this.planetLayer.show();
        this.starLayer.show();
    }

    // has to be async so the toImage promise can be waited on
    private async startViewingPlanet(planet: Planet) {
        this.planetLayer.hide();
        this.starLayer.hide();
        this.sectionLayer.hide();
        this.bgRect.removeEventListener('click');
        // return to the solar system view when the background is clicked
        this.bgRect.on('click', (e) => {
            this.startViewingSolarSystem();
        })
        // ensure the orbitAnimation is stopped
        this.orbitAnimation.stop();
        this.planetLayer.destroy();
        this.starLayer.destroy();
        this.stage.add(this.sectionLayer);
        this.planetText.setAttrs({
            x: this.stage.width() / 2 - (this.planetText.fontSize() * this.planetText.pixelSize()) / 2,
            y: this.stage.height() / 2 - 200,
            fontSize: 30,
        });
        this.sectionLayer.add(this.planetText);

        // create a wedge for each section
        var planetRadius = 150
        for (let i = 0; i < planet.sections.length; i++) {
            const section = planet.sections[i];
            var wedge = new Konva.Wedge({
                x: this.stage.width() / 2,
                y: this.stage.height() / 2,
                radius: planetRadius,
                angle: 90,
                fill: section.category.colour,
                stroke: CIRCLE_STROKE_COLOUR,
                strokeWidth: 0,
                rotation: i * 90,
                opacity: 0.4
            });
            // this will eventually be the actual planet section image (still waiting on graphics)
            section.wedge = await wedge.toImage({
            }) as HTMLImageElement;
            var text = new Konva.Text({
                x: 0,
                y: 0,
                text: '',
                fontSize: 15,
                fontFamily: 'Arial',
                fill: 'white'
            });
            // tell konva not to track any events on the text object for optimisation purposes
            text.listening(false);

            wedge.on('mouseover', (e) => {
                var displayText = `${section.category.name}\n${section.goals.length} Goals`
                text.text(displayText);
                text.x(e.target.getAttr('x'));
                text.y(e.target.getAttr('y') + 200);

                e.target.setAttr('stroke', HIGHLIGHT_CIRCLE_STROKE_COLOUR);
                e.target.setAttr('strokeWidth', HIGHLIGHT_CIRCLE_STROKE_WIDTH);

                e.target.moveToTop();
                text.moveToTop();
            });
            wedge.on('mouseout', (e) => {
                text.text('');
                e.target.setAttr('stroke', CIRCLE_STROKE_COLOUR);
                e.target.setAttr('strokeWidth', CIRCLE_STROKE_WIDTH);
            });
            wedge.on('click', (e) => {
                this.openDialog(section);
                // this.drawSolarSystem();
            });

            this.sectionLayer.add(text);
            this.sectionLayer.add(wedge);
        }

        // create the planet image
        var planetImg = new Konva.Image({
            image: planet.image,
            x: this.stage.width() / 2 - planetRadius,
            y: this.stage.height() / 2 - planetRadius,
            width: planetRadius * 2,
            height: planetRadius * 2,
        });
        this.sectionLayer.add(planetImg);
        planetImg.moveToBottom();
        planetImg.listening(false);
        this.sectionLayer.show();
    }



    /**
     * Generates a random circle with the assigned centre point and minimum and max sizes.
     * @param point
     * @param minSize
     * @param maxSize
     * @returns circleData
     */
    private getRandomCircle(point: Point, minSize: number, maxSize: number): CircleData {
        let fillColour = getRandomColourCode();
        let size = randInt(minSize, maxSize)
        const circleData = this.getCircle(
            point,
            size,
            fillColour,
        )
        return circleData;
    }

    private getRandomSections() {
        const sections: Section[] = [];
        for (let i = 0; i < 4; i++) {
            const category = this.setCategories[i];

            const goals: Goal[] = [];
            // create goals for the section
            for (let j = 0; j < randInt(1, 4); j++) {
                const plans: TextData[] = [];
                for (let k = 0; k < randInt(0, 3); k++) {
                    plans.push({
                        title: 'Plan' + k + j + i,
                        content: 'This is some quality plan content'
                    });
                }
                const reflections: TextData[] = [];
                for (let k = 0; k < randInt(0, 3); k++) {
                    reflections.push({
                        title: 'Reflection' + k + j + i,
                        content: 'This is some quality reflection content'
                    });
                }
                goals.push({
                    title: 'Goal ' + j + i,
                    content: 'This is some good goal content right here!',
                    plans,
                    reflections
                })
            }

            sections.push({
                category,
                goals
            });
        }
        return sections;
    }

    /**
     * Creates a random number of planets and their orbit circles
     *
     * Each planet has a random radius and speed
     *
     * @returns planetList -> A list of randomly generated planets
     */
    public getPlanetList() {
        const planetList = [];

        let angleCtr = 0;
        let addOrbitDist = 40;
        let maxOrbitDist = 500;
        let orbitCtr = 0;
        const minOrbitDist = 40;
        const midPoint = this.getCanvasMidPoint();

        for (let i = 0; i < randInt(2, 7); i++) {
            let orbitDist = (minOrbitDist * this._viewSystemZoom) + ((++orbitCtr * addOrbitDist) % maxOrbitDist)
            let angle = angleCtr;

            angleCtr += this._addOrbitAngle;

            let planetPoint = getCirclePoint(this.getCanvasMidPoint(), orbitDist, angle);
            let orbitCircle = this.getCircle(this.getCanvasMidPoint(), orbitDist, '', ORBIT_CIRCLE_STROKE_COLOUR, ORBIT_CIRCLE_STROKE_WIDTH);
            let planetCircle = this.getRandomCircle(planetPoint, 15, 20);

            let imgPath = `assets/Planets/planet-${randInt(1, 8)}.png`
            var planetImgObj = new Image();
            planetImgObj.src = imgPath;

            const planet: Planet = {
                id: i,
                size: planetCircle.radius,
                circle: planetCircle,
                orbitCircle: orbitCircle,
                offset: {
                    x: midPoint.x - planetCircle.center.x,
                    y: midPoint.y - planetCircle.center.y,
                } as Point,
                name: 'Planet ' + (i),
                kplanetCircle: {} as Konva.Circle,
                korbitCircle: {} as Konva.Circle,
                clicked: false,
                collided: false,
                speed: 1 + Math.random(),
                lostFrames: 0,
                image: planetImgObj,
                imagePath: imgPath,
                sections: this.getRandomSections()
            }
            planetList.push(planet);
        }
        return planetList
    }

    /**
     * Creates a CircleData object, with optional parameters filled with constant values
     * @param center
     * @param radius
     * @param fillColour
     * @param strokeColour
     * @param strokeWidth
     * @returns
     */
    private getCircle(center: Point, radius: number, fillColour = 'yellow', strokeColour = CIRCLE_STROKE_COLOUR, strokeWidth = CIRCLE_STROKE_WIDTH): CircleData {
        return {
            center,
            radius,
            fillColour,
            strokeColour,
            strokeWidth
        } as CircleData;
    }

    /**
     * Uses the planets from this.planetList to create konva circles and images
     *
     * Creates circles for the planets, images to display for the planets and orbit circles which the planets follow in their animation
     *
     * The circles are used for hit detection (mouseover, mouseout, click)
     *
     * Both are animated to simulate orbiting around the central star.
     *
    */
    private addPlanetsToLayer() {
        this.planetLayer.hide();
        this.planetLayer.destroyChildren();
        const planetCircles = [];
        const planetImgs = [];

        for (let i = 0; i < this.planetList.length; i++) {
            const planet = this.planetList[i];

            var planetCircle = new Konva.Circle({
                x: planet.circle.center.x,
                y: planet.circle.center.y,
                stroke: planet.circle.strokeColour,
                strokeWidth: planet.circle.strokeWidth,
                radius: planet.circle.radius,
                opacity: CIRCLE_OPACITY
            });

            var planetImg = new Konva.Image({
                image: planet.image,
                x: planet.circle.center.x - planet.circle.radius,
                y: planet.circle.center.y - planet.circle.radius,
                width: planet.circle.radius * 2,
                height: planet.circle.radius * 2,
            });

            this.planetList[i].kplanetCircle = planetCircle;

            this.planetLayer.add(planetCircle);
            this.planetLayer.add(planetImg);

            this.planetText = new Konva.Text({
                x: 0,
                y: 0,
                text: '',
                fontSize: 15,
                fontFamily: 'Arial',
                fill: 'white'
            });
            this.planetLayer.add(this.planetText);
            // tell konva not to track any events on the text object for optimisation purposes
            this.planetText.listening(false);

            planetCircle.on('mouseover', (e) => {
                if (!planet.clicked) {
                    planet.collided = true;
                    this.planetText.x(e.target.getAttr('x') - planet.name.length * 3);
                    this.planetText.y(e.target.getAttr('y') - 40);
                    this.planetText.text(planet.name);

                    e.target.setAttr('stroke', HIGHLIGHT_CIRCLE_STROKE_COLOUR);
                    e.target.setAttr('strokeWidth', HIGHLIGHT_CIRCLE_STROKE_WIDTH);
                    e.target.setAttr('opacity', SELECT_CIRCLE_OPACITY);
                    e.target.moveToTop();
                    this.planetText.moveToTop();
                }
            });
            planetCircle.on('mouseout', (e) => {
                // keep the clicked planet selected on mouseout
                if (!planet.clicked) {
                    planet.collided = false;

                    this.planetText.text('');

                    e.target.setAttr('stroke', CIRCLE_STROKE_COLOUR);
                    e.target.setAttr('strokeWidth', CIRCLE_STROKE_WIDTH);
                    e.target.setAttr('opacity', CIRCLE_OPACITY);

                }
            });
            planetCircle.on('click', (e) => {
                // reset any other clicked planets when a planet is clicked
                for (let i = 0; i < this.planetList.length; i++) {
                    this.planetList[i].collided = false;
                    this.planetList[i].clicked = false;
                    this.planetList[i].kplanetCircle.setAttrs({
                        'stroke': CIRCLE_STROKE_COLOUR,
                        'strokeWidth': CIRCLE_STROKE_WIDTH
                    });
                    this.planetList[i].lostFrames = 0;
                }
                // we open planet view as soon as a planet is clicked
                // so all the below formatting is not required (at the moment)

                // planet.clicked = true;
                // planet.collided = true;

                // text.text(planet.name);
                // text.x(e.target.getAttr('x') - planet.name.length * 3);
                // text.y(e.target.getAttr('y') - 40);

                // e.target.setAttr('stroke', SELECT_CIRCLE_STROKE_COLOUR);
                // e.target.setAttr('strokeWidth', SELECT_CIRCLE_STROKE_WIDTH);
                // e.target.moveToTop();
                // text.moveToTop();

                this.startViewingPlanet(this.planetList[i]);
            })

            var orbitCircle = new Konva.Circle({
                x: planet.orbitCircle.center.x,
                y: planet.orbitCircle.center.y,
                stroke: planet.orbitCircle.strokeColour,
                strokeWidth: planet.orbitCircle.strokeWidth,
                fill: planet.orbitCircle.fillColour,
                radius: planet.orbitCircle.radius
            });

            // currently, just clear any currently clicked planets if an orbit circle is clicked
            orbitCircle.on('click', (e) => {
                this.planetText.text('');
                for (let i = 0; i < this.planetList.length; i++) {
                    this.planetList[i].collided = false;
                    this.planetList[i].clicked = false;
                    this.planetList[i].kplanetCircle.setAttrs({
                        'stroke': CIRCLE_STROKE_COLOUR,
                        'strokeWidth': CIRCLE_STROKE_WIDTH
                    });
                }
            })
            this.planetLayer.add(orbitCircle);

            // TODO: highlight orbit circles on mouseover?
            // orbitCircle.on('mouseover', function () {
            //     planet.collided = true;
            //     this.setAttr('stroke', HIGHLIGHT_ORBIT_CIRCLE_COLOUR);
            //     this.setAttr('strokeWidth', HIGHLIGHT_ORBIT_CIRCLE_WIDTH);
            // });
            // orbitCircle.on('mouseout', function () {
            //     this.setAttr('stroke', ORBIT_CIRCLE_STROKE_COLOUR);
            //     this.setAttr('strokeWidth', ORBIT_CIRCLE_STROKE_WIDTH);
            //     planet.collided = false;
            // });

            planetImgs.push(planetImg);
            planetCircles.push(planetCircle);
            orbitCircle.moveToBottom();
            planetCircle.moveToTop();
        }

        var midpoint = this.getCanvasMidPoint();

        // animate the planets orbiting in perfect circles around the centre of the page
        this.orbitAnimation = new Konva.Animation((frame) => {
            for (var i = 0; i < this.planetList.length; i++) {
                // freeze the planet if it has collided with the cursor
                if (!this.planetList[i].collided) {
                    // obtain the current angle of the planet to the centre of the page
                    var angle = getAngle(midpoint, this.planetList[i].circle.center);
                    // calculate an amount to add the current angle to simulate the planet moving around the circle
                    // this uses the current frame.time value in the calculation
                    // since planets can be frozen during mouse events, the number of lost frames for each planet must also be tracked
                    // the lost frames are subtracted from the frame.time value to ensure smooth movement for planets
                    var add = ((frame.time - this.planetList[i].lostFrames) / 10) * this.planetList[i].speed / this.planetList[i].size;
                    angle = angle + add;
                    angle = (Math.PI * angle) / 180;
                    // a new centre for the planet is calculated using the new angle
                    var newCentre = getCirclePoint(
                        midpoint,
                        getDistance(midpoint, this.planetList[i].circle.center),
                        angle
                    );
                    // the planet circle is assigned to its new centre point
                    planetCircles[i].x(newCentre.x);
                    planetCircles[i].y(newCentre.y);
                    // the planet image must have its point adjusted, to ensure it is placed in the centre of the circle
                    planetImgs[i].x(newCentre.x - this.planetList[i].circle.radius);
                    planetImgs[i].y(newCentre.y - this.planetList[i].circle.radius);
                    // planetImgs[i].rotation((frame.time - this.planetList[i].lostFrames) % 360)
                } else {
                    // increase the lost frames counter whenever the planet misses a frame due to mouse events
                    this.planetList[i].lostFrames += frame.timeDiff;
                }
            }
        }, this.planetLayer);
        this.planetLayer.show();
    }

    // TODO: a private centrePoint value should be created in AfterInit function rather than relying on this function
    private getCanvasMidPoint(): Point {
        return {
            x: this.stage.width() / 2,
            y: this.stage.height() / 2
        };
    }

    /**
     * Create a black rectangle that fills the canvas container
     *
     * Uses this.bgStarList to create Konva.Circles to create a starry background
     *
     * Each star has a random opacity to simulate brightness
     */
    private addBgStarsToLayer() {
        this.bgLayer.destroyChildren();
        this.bgRect = new Konva.Rect({
            x: 0,
            y: 0,
            width: window.document.getElementById('container').clientWidth,
            height: window.document.getElementById('container').clientHeight,
            fill: 'black'
        });

        this.bgLayer.add(this.bgRect);

        for (let i = 0; i < this.bgStarList.length; i++) {
            const bgStar = this.bgStarList[i];
            var starCircle = new Konva.Circle({
                x: bgStar.center.x,
                y: bgStar.center.y,
                radius: bgStar.radius,
                opacity: bgStar.brightness / 10,
                fill: 'white'
            });
            this.bgLayer.add(starCircle);
            // turn off events for all the stars for optimisation purposes
            starCircle.listening(false);
        }
    }

    /**
     * Creates a Konva.Group containing the category polygons and the category star spikes, both as Konva.Shape
     *
     * Sets up all mouse events for each of the category polygons to allow them to be highlighted and have their name displayed onscreen
     *
     * @param starCoords
     * @param center
     * @param polyFillColour
     * @returns Konva.Group
     */
    private getStarGroup(starCoords: StarCoord[], center: Point, polyFillColour: string): Konva.Group {
        var starGroup = new Konva.Group({
            x: center.x,
            y: center.y
        });
        const polyList = [];
        for (var i = 0; i < this.catPolygons.length; i++) {
            const poly = this.catPolygons[i];

            var polygon = new Konva.Shape({
                x: center.x,
                y: center.y,
                fill: polyFillColour,
                stroke: 'gold',
                strokeWidth: 1,
                // a Konva.Canvas renderer is passed into the sceneFunc function
                sceneFunc(context, shape) {
                    context.beginPath();
                    context.moveTo(poly.points.centre.x, poly.points.centre.y);
                    context.lineTo(poly.points.edgeL.x, poly.points.edgeL.y);
                    context.lineTo(poly.points.spike.x, poly.points.spike.y);
                    context.lineTo(poly.points.edgeR.x, poly.points.edgeR.y);
                    context.lineTo(poly.points.centre.x, poly.points.centre.y);
                    context.closePath();
                    // Konva specific method
                    context.fillStrokeShape(shape);
                }
            });
            var mid = this.getCanvasMidPoint();
            var text = new Konva.Text({
                x: mid.x,
                y: mid.y,
                text: '',
                fontSize: 15,
                fontFamily: 'Arial',
                fill: 'white'
            });

            polygon.on('pointerenter', function (evt) {
                this.setAttr('stroke', poly.category.colour);
                this.setAttr('StrokeWidth', 3);
                this.moveToTop();
                text.setAttr('text', poly.category.name);
                text.setAttr('x', mid.x - 35);
                text.setAttr('y', mid.y + 75);
            });
            polygon.on('pointerleave', function () {
                this.setAttr('stroke', 'gold');
                this.setAttr('StrokeWidth', 1);
                text.setAttr('text', '');
            });
            starGroup.add(text);
            starGroup.add(polygon);
            polyList.push(polygon);
        }
        for (var i = 0; i < starCoords.length; i++) {
            const starCoord = starCoords[i];
            const kPoly = polyList[i];
            const poly = this.catPolygons[i];
            var catSpike = new Konva.Shape({
                x: center.x,
                y: center.y,
                fill: 'black',
                opacity: 0.5,
                stroke: this.setCategories[i].colour,
                strokeWidth: 5,
                sceneFunc: function (context, shape) {
                    context.beginPath();
                    context.moveTo(starCoord.edgeR.x, starCoord.edgeR.y)
                    context.lineTo(starCoord.spike.x, starCoord.spike.y)
                    context.lineTo(starCoord.edgeL.x, starCoord.edgeL.y)

                    context.fillStrokeShape(shape)
                }
            });

            catSpike.on('pointerenter', (evt) => {
                kPoly.setAttr('stroke', poly.category.colour);
                kPoly.setAttr('StrokeWidth', 3);
                evt.target.setAttr('opacity', 1);
                kPoly.moveToTop();
                text.setAttr('text', poly.category.name);
                text.setAttr('x', mid.x - 35);
                text.setAttr('y', mid.y + 75);
            });
            catSpike.on('pointerleave', (evt) => {
                evt.target.setAttr('opacity', 0.5);

                kPoly.setAttr('stroke', 'gold');
                kPoly.setAttr('StrokeWidth', 1);
                text.setAttr('text', '');
            });
            starGroup.add(catSpike);
            catSpike.moveToBottom();
        }

        return starGroup;
    }
}
