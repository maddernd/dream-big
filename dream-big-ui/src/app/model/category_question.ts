import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'question',
    'category_id'
  ];

export class CategoryQuestion extends Entity {
  id: number = -1;
  question: string = "";
  category_id: number = -1;

  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}