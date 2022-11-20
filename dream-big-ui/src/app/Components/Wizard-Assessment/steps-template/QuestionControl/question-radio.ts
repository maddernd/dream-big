import { TestQuestions } from '../TestQuestions';

export class QuestionRadio extends TestQuestions<string> {
    TestQuestions = 'radio';
    options: { key: string, value: string }[] = [];

    constructor(options: {} = {}) {
        super(options);
        this.options = options['options'] || [];
    }
}
