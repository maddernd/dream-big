import { style } from "@angular/animations";
import { DialogRef, DIALOG_DATA } from "@angular/cdk/dialog";
import { Component, Inject, Input } from "@angular/core";
import { Section } from "src/app/helpers/types";

export interface DialogData {
	name: string;
  }

@Component({
	selector: 'app-section-dialog',
	templateUrl: 'section-dialog.component.html',
})





export class SectionDialogComponent {


	constructor(public dialogRef: DialogRef<string>, @Inject(DIALOG_DATA) public data: Section) { }

  color1 = "option";
  color2 = "option";
  color3 = "option";
  color4 = "option";
  color5 = "option";
  color6 = "option";
  color7 = "option";
  color8 = "option";
  color9 = "option";
  updatecolor1()
  {
      this.color1 = "selected";
  }
  updatecolor2()
  {
      this.color2 = "selected";
  }
  updatecolor3()
  {
      this.color3 = "selected";
  }
  updatecolor4()
  {
      this.color4 = "selected";
  }
  updatecolor5()
  {
      this.color5 = "selected";
  }
  updatecolor6()
  {
      this.color6 = "selected";
  }
  updatecolor7()
  {
      this.color7 = "selected";
  }
  updatecolor8()
  {
      this.color8 = "selected";
  }
  updatecolor9()
  {
      this.color9 = "selected";
  }
}
