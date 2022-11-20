import { TestQuestions } from '../TestQuestions';

export class QuestionSelect extends TestQuestions<string> {
    TestQuestions = 'select';
    options: { key: string, value: string }[] = [];

    constructor(options: {} = {}) {
        super(options);
        this.options = options['options'] || [];
    }
}