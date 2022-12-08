import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'journey_id',
    'category_id'
  ];

export class Assessment extends Entity {
  id: number = -1;
  journey_id: number = -1;
  category_id: number = -1;
  
  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}