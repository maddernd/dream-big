import { TestQuestions } from '../TestQuestions';

export class QuestionTextbox extends TestQuestions<string> {
    QuestionControl = 'textbox';
    type: string;

    constructor(options: {} = {}) {
        super(options);
        this.type = options['type'] || '';
    }
}
