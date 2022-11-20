import { Injectable } from '@angular/core';

import { TestQuestions } from '../TestQuestions';

import { QuestionTextbox } from '../QuestionControl/question-textbox';
import { QuestionSelect } from '../QuestionControl/question-select';
import { QuestionRadio } from '../QuestionControl/question-radio';

@Injectable({
  providedIn: 'root'
})
export class QuestionService {
  getQuestions() {
    const questions: TestQuestions<any>[] = [
      new QuestionTextbox({
        key: 'Basic',
        label: 'Engagement',
        value: 'Accepts Allocated Work Completing it in an acceptable time frame.',
        options: [
            { key: 'Always', value: 'Yes' },
            { key: 'Sometimes', value: 'No' },
            { key: 'Never', value: 'No' }
          ],
        order: 1
      }),
      new QuestionSelect({
        key: 'basic2',
        label: 'Time Management',
        options: [
          { key: 'Always', value: 'Yes' },
          { key: 'Sometimes', value: 'No' },
          { key: 'Never', value: 'No' }
        ],
        order: 2
      }),
      new QuestionTextbox({
        key: 'Core',
        label: 'Communication',
        value: 'Can communicate in a proffesional Mannor',
        options: [
            { key: 'Always', value: 'Yes' },
            { key: 'Sometimes', value: 'No' },
            { key: 'Never', value: 'No' }
          ],
        order: 3
      }),
      new QuestionSelect({
        key: 'core2',
        label: 'position and opportunites',
        value: 'Understand role in the team and or orgnastion.',
        options: [
            { key: 'Always', value: 'Yes' },
            { key: 'Sometimes', value: 'No' },
            { key: 'Never', value: 'No' }
          ],
        order: 4
      })
    ];

    return questions.sort((a, b) => a.order - b.order);
  }
}