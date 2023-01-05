import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'category_question_id',
    'assessment_id',
    'answer'
  ];

export class Answer extends Entity {
  id: number = -1;
  category_question_id: number = -1;
  assessment_id: number = -1;
  answer: string = "";
  
  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}