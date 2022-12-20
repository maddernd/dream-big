import { Component, OnInit, Input, ViewEncapsulation } from '@angular/core';
import { StepModel } from 'src/app/model/step.model';

@Component({
  selector: 'app-step-template',
  templateUrl: './steps-template.component.html',
  styleUrls: ['./steps-template.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class StepTemplateComponent implements OnInit {

  @Input()
  step: StepModel;

  constructor() { }

  ngOnInit(): void {
  }

  onCompleteStep() {
    this.step.isComplete = true;
  }
}
