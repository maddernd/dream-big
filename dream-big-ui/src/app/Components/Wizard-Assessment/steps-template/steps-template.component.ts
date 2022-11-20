import { Component, OnInit, Input, ViewEncapsulation } from '@angular/core';
import { StepModel } from 'src/app/model/step.model';
import { CategoryQuestion} from 'src/app/model/category_question'
import {Assessment} from 'src/app/model/assessment'
import { Answer } from 'src/app/model/answer';

@Component({
  selector: 'app-step-template',
  templateUrl: './steps-template.component.html',
  styleUrls: ['./steps-template.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class StepTemplateComponent implements OnInit {

  @Input()
  step: StepModel;
  answer: Answer;
  question: CategoryQuestion;


  constructor() { }

  ngOnInit(): void {
  }

  onCompleteStep() {
    this.step.isComplete = true;
  }

}