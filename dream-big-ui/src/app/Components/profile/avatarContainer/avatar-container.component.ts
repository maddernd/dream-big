import { Component, ElementRef, EventEmitter, Input, OnInit, Output, ViewChild } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { CommonModule } from '@angular/common';

import { User } from 'src/app/model/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

import { AuthGuard } from 'src/app/services/authguard.service';
import { AvatarService } from 'src/app/services/avatar.service';
import { Journey } from 'src/app/model/journey';
import { JourneyService } from 'src/app/services/journey.service';
import {
  GlassesTypes,
  ClothingGraphicTypes,
  ClothingTypes,
  Colors,
  EyebrowTypes,
  EyeTypes,
  FacialHairTypes,
  HairTypes, MouthTypes,
  NoseTypes,
  Texts
} from "../../../helpers/model";
import {randomIntFromInterval, randomizeColor} from "../../../helpers/helper";

@Component({
  selector: 'app-avatar-container',
  templateUrl: './avatar-container.component.html',
  styleUrls: ['./avatar-container.component.scss']
})
export class AvatarContainerComponent implements OnInit {

  mydata = [
    {
      "id" : 1,
      "position" : "head",
      "color" : "blue"
    },
    {
      "id" : 2,
      "position" : "hair",
      "color" : "red"
    },
    {
      "id" : 3,
      "position" : "accessorice",
      "color" : "green"
    }
  ]
  @Input() public shape: 'round' | 'square' = 'round';
  @Input() public enableBackground: boolean;
  @Input() public enableFace: boolean;
  @Input() public displayDownload: boolean;
  @Input() public texts: Texts = {
    eyes: 'Eyes',
    mouth: 'Mouth',
    nose: 'Nose',
    face: 'Face Details',
    facialHair: 'Facial Hair',
    glasses: 'Glasses',
    everything: 'EVERYTHING',
    allColors: 'All colors',
    background: 'Background',
    skin: 'Skin',
    hair: 'Hair',
    hairStyle: 'Hair Style',
    eyebrows: 'Eyebrows',
    accessory: 'Accessory',
    clothes: 'Clothes',
    clothing: 'Clothing',
    print: 'Print'
  };
  @Output() private svgUrl = new EventEmitter<string>();
  @ViewChild('avatar', {read: ElementRef}) avatar: ElementRef;

  public hairType: {
    name: HairTypes,
    index: number
  };
  public eyebrowType: {
    name: EyebrowTypes,
    index: number
  };
  public eyeType: {
    name: EyeTypes,
    index: number
  };
  public noseType: {
    name: NoseTypes,
    index: number
  };
  public mouthType: {
    name: MouthTypes,
    index: number
  };
  public facialHairType: {
    name: FacialHairTypes,
    index: number
  };
  public glassesType: {
    name: GlassesTypes,
    index: number
  };
  public clothing: {
    name: ClothingTypes,
    index: number
  };
  public clothingGraphic: {
    name: ClothingGraphicTypes,
    index: number
  };
  public colors: Colors = {
    hair: '',
    skin: '',
    clothes: '',
    graphic: '',
    accessory: '',
    background: '',
    eyebrows: '',
    eyes: '',
    mouth: '',
    facialHair: '',
    glasses: ''
  };

  public randomizeColor = randomizeColor;

  private hairTypesArray = Object.keys(HairTypes);
  private eyebrowTypesArray = Object.keys(EyebrowTypes);
  private eyeTypesArray = Object.keys(EyeTypes);
  private noseTypesArray = Object.keys(NoseTypes);
  private mouthTypesArray = Object.keys(MouthTypes);
  private facialHairTypesArray = Object.keys(FacialHairTypes);
  private glassesTypesArray = Object.keys(GlassesTypes);
  private clothingTypesArray = Object.keys(ClothingTypes);
  private clothingGraphicTypesArray = Object.keys(ClothingGraphicTypes);

  public HairTypes = HairTypes;
  public EyeTypes = EyeTypes;
  public ClothingTypes = ClothingTypes;

  private url: string;

  //profile form toggle check
  public profileForm : boolean = false;

  //Avatar Data ScreenShots:
  public initAvatarScreenShot: [string, HairTypes, string, string, ClothingTypes, string, string];
  public updatedAvatarScreenShot: [string, HairTypes, string, string, ClothingTypes, string, string];

  //discard pop up toggle
  public DiscardPopUp : boolean = false;

  constructor(private router: Router, private authService: AuthService) { }

  ngOnInit() {
    this.goCompletelyRandom();
    //sets init avatar data
    this.setInitAvatarScreenShot();
  }

  //change/update init avatar screenshot function
  public setInitAvatarScreenShot(){
    this.initAvatarScreenShot = [
      this.colors.skin,
      this.hairType.name,
      this.colors.hair,
      this.colors.accessory,
      this.clothing.name,
      this.colors.clothes,
      this.colors.graphic
    ]
  }
  //change/update updated avatar screenshot function
  public setUpdatedAvatarScreenShot(){
    this.updatedAvatarScreenShot = [
      this.colors.skin,
      this.hairType.name,
      this.colors.hair,
      this.colors.accessory,
      this.clothing.name,
      this.colors.clothes,
      this.colors.graphic
    ]
  }

  //compares two arrays, if different, returns false, if same, returns true
  public compareAvatarScreenShots(init : Array<string>, updated : Array<string>) : boolean{
    for(let i = 0; i < init.length - 1; i++){
      if(init[i] != updated[i]){
        return false;
      }
    }
    return true;
  }

  //reverts avatar to original state before changes
  public revertAvatar(){
    this.colors.skin = this.initAvatarScreenShot[0];
    this.hairType.name = this.initAvatarScreenShot[1];
    this.colors.hair = this.initAvatarScreenShot[2];
    this.colors.accessory = this.initAvatarScreenShot[3];
    this.clothing.name = this.initAvatarScreenShot[4];
    this.colors.clothes = this.initAvatarScreenShot[5];
    this.colors.graphic = this.initAvatarScreenShot[6];
  }

  //saves new avatar data
  public save(){
    alert("Avatar saved!");
    this.setInitAvatarScreenShot();
  }

  //toggles the profile form but also checks if user has saved and changes before closing
  public toggleProfileForm(){
    //if profile form is showing
    if(this.profileForm == true){
      this.setUpdatedAvatarScreenShot();//update the updateAvatarScreenshot with Avatar's current data
      //if the avatar data hasn't changed
      if (this.compareAvatarScreenShots(this.initAvatarScreenShot, this.updatedAvatarScreenShot)){
        this.profileForm = false; //close form
      }
      //if avatar has changed
      else{
        this.DiscardPopUp = true;//show discard pop up
      }
    //if profile form isnt showing, show it
    }else{
      this.profileForm = true;
    }
  }

  //if user chooses to discard avatar changes
  public discard(){
    this.DiscardPopUp = false; //close pop up
    this.profileForm = !this.profileForm; //close profile form
    this.revertAvatar(); //reverts avatar to orginal state before changing
    this.setInitAvatarScreenShot(); //retakes init avatar screenshot
  }

  //if user chooses not to discard avatar changes
  public dontDiscard(){
    this.DiscardPopUp = false; //close pop up
  }

  public goCompletelyRandom(): void {
    this.getRandomColors();
    this.getRandomHairStyle();
    this.getRandomEyebrowType();
    this.getRandomEyeType();
    this.getRandomNoseType();
    this.getRandomMouthType();
    this.getRandomFacialHairType();
    this.getRandomGlassesType();
    this.getRandomClothing();
    this.getRandomClothingGraphic()
  }

  public getRandomColors(): void {
    for (const [key, value] of Object.entries(this.colors)) {
      this.colors[key] = randomizeColor();
    }
  }

  public getRandomHairStyle(): void {
    this.hairType = this.getRandomStyle(this.hairTypesArray, HairTypes);
  }

  public getRandomEyebrowType(): void {
    this.eyebrowType = this.getRandomStyle(this.eyebrowTypesArray, EyebrowTypes);
  }

  public getRandomEyeType(): void {
    this.eyeType = this.getRandomStyle(this.eyeTypesArray, EyeTypes);
  }

  public getRandomNoseType(): void {
    this.noseType = this.getRandomStyle(this.noseTypesArray, NoseTypes);
  }

  public getRandomMouthType(): void {
    this.mouthType = this.getRandomStyle(this.mouthTypesArray, MouthTypes);
  }

  public getRandomFacialHairType(): void {
    this.facialHairType = this.getRandomStyle(this.facialHairTypesArray, FacialHairTypes);
  }

  public getRandomGlassesType(): void {
    this.glassesType = this.getRandomStyle(this.glassesTypesArray, GlassesTypes);
  }

  public getRandomClothing(): void {
    this.clothing = this.getRandomStyle(this.clothingTypesArray, ClothingTypes);
  }

  public getRandomClothingGraphic(): void {
    this.clothingGraphic = this.getRandomStyle(this.clothingGraphicTypesArray, ClothingGraphicTypes);
  }

  public iterateOverHairTypes(upwards: boolean): void {
    this.hairType = this.iterateOverOptions(this.hairType, this.hairTypesArray, HairTypes, upwards);
  }

  public iterateOverEyebrowTypes(upwards: boolean): void {
    this.eyebrowType = this.iterateOverOptions(this.eyebrowType, this.eyebrowTypesArray, EyebrowTypes, upwards);
  }

  public iterateOverEyeTypes(upwards: boolean): void {
    this.eyeType = this.iterateOverOptions(this.eyeType, this.eyeTypesArray, EyeTypes, upwards);
  }

  public iterateOverNoseTypes(upwards: boolean): void {
    this.noseType = this.iterateOverOptions(this.noseType, this.noseTypesArray, NoseTypes, upwards);
  }

  public iterateOverMouthTypes(upwards: boolean): void {
    this.mouthType = this.iterateOverOptions(this.mouthType, this.mouthTypesArray, MouthTypes, upwards);
  }

  public iterateOverFacialHairTypes(upwards: boolean): void {
    this.facialHairType = this.iterateOverOptions(this.facialHairType, this.facialHairTypesArray, FacialHairTypes, upwards);
  }

  public iterateOverGlassesTypes(upwards: boolean): void {
    this.glassesType = this.iterateOverOptions(this.glassesType, this.glassesTypesArray, GlassesTypes, upwards);
  }

  public iterateOverClothingTypes(upwards: boolean): void {
    this.clothing = this.iterateOverOptions(this.clothing, this.clothingTypesArray, ClothingTypes, upwards);
  }

  public iterateOverClothingGraphicTypes(upwards: boolean): void {
    this.clothingGraphic = this.iterateOverOptions(this.clothingGraphic, this.clothingGraphicTypesArray, ClothingGraphicTypes, upwards);
  }

  private getRandomStyle(typesArray: Array<any>, enumm: typeof HairTypes | typeof ClothingTypes | typeof ClothingGraphicTypes | typeof EyebrowTypes | typeof EyeTypes | typeof NoseTypes | typeof MouthTypes | typeof FacialHairTypes | typeof GlassesTypes): { name: any, index: number } {
    const index = randomIntFromInterval(0, typesArray.length - 1);
    return {
      name: enumm[typesArray[index]],
      index: index
    };
  }

  private iterateOverOptions(value: { name: any, index: number }, typesArray: Array<any>, enumName: typeof HairTypes | typeof ClothingTypes | typeof ClothingGraphicTypes | typeof EyebrowTypes | typeof EyeTypes | typeof NoseTypes | typeof MouthTypes | typeof FacialHairTypes | typeof GlassesTypes, upwards: boolean): { name: any, index: number } {
    let newIndex = upwards ? value.index + 1 : value.index - 1;
    if (newIndex === typesArray.length) {
      newIndex = 0;
    } else if (newIndex === -1) {
      newIndex = typesArray.length - 1
    }
    return {
      name: enumName[typesArray[newIndex]],
      index: newIndex
    };
  }

  public prepareLink(): void {
    const svg = this.avatar?.nativeElement?.querySelector('svg');
    const serializer = new XMLSerializer();
    if (svg) {
      let source = serializer.serializeToString(svg);
      source = '<?xml version="1.0" standalone="no"?>\r\n' + source;
      const url = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(source);
      this.url = url.replace(/%3C!--.*?--%3E/g, '');
      this.svgUrl.emit(this.url);
    }
  }

  public doDownload(format: string): void {
    // if (format === 'png') {
    //   svg.saveSvgAsPng(this.avatar?.nativeElement?.querySelector('svg'), 'avatar.png');
    // } else {
    //   const downloadLink = document.createElement("a");
    //   downloadLink.href = this.url;
    //   downloadLink.download = "avatar.svg";
    //   document.body.appendChild(downloadLink);
    //   downloadLink.click();
    //   document.body.removeChild(downloadLink);
    // }
  }

  public getColorsObject() {
    return {...this.colors};
  }

}