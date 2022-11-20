import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { TestQuestions } from '../TestQuestions';

@Injectable({
  providedIn: 'root'
})
export class QuestionControlService {

  constructor() { }

  toFormGroup(questions: TestQuestions<any>[]) {
    const group: any = {};

    questions.forEach(question => {
      group[question.key] = question.required ?
        new FormControl(question.value || '', Validators.required) :
        new FormControl(question.value || '');
    });
    return new FormGroup(group);
  }
}