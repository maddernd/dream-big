import Konva from "konva";

export interface Point {
    x: number;
    y: number;
}

export interface Category {
    name: string;
    score: number;
    colour: string;
}


export interface PolygonPoints {
    spike: Point;
    edgeL: Point;
    edgeR: Point;
    centre: Point;


}
export interface Polygon {
    points: PolygonPoints

    highlight: boolean;
    category: Category;
    path: {};
}

export interface StarCoord {
    spike: Point;
    edgeL: Point;
    edgeR: Point;
    category: Category;
}

export interface StarData {
    starCoords: StarCoord[];
    outerRatio: number;
    innerRatio: number;
    size: number;
    rotation: number;
    centre: Point;
    categories: Category[];
    catPolygons: Polygon[];
}

export interface BgStar {
    center: Point;
    brightness: number;
    radius: number;
}

export interface CircleSprite {
    id: number
    size: number
    circle: CircleData
    clicked: boolean
    collided: boolean
    // imageId: number
    // imageRaster: paper.Raster
}

export interface Star extends CircleSprite {
    name: string
}

export interface Planet extends CircleSprite {
    offset: Point
    orbitCircle: CircleData
    korbitCircle: Konva.Circle,
    kplanetCircle: Konva.Circle,
    kplanetImage?: Konva.Image,
    name: string
    speed: number
    lostFrames: number
    image: HTMLImageElement;
    imagePath: string;
    sections: Section[];
}

export interface Section {
    wedge?: HTMLImageElement
    category: Category,
    goals?: Goal[]
}

export interface TextData {
    title: string,
    content: string
}

export interface Goal extends TextData {
    plans?: TextData[]
    reflections?: TextData[]
}

export interface CircleData {
    center: Point
    radius: number
    fillColour: string
    strokeColour: string
    strokeWidth: number
}


export interface SolarSystem {
    id: number
    name: string
    status: string
    star: Star
    planets: Planet[]
}
