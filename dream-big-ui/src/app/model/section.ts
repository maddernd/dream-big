import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'planet_id',
    'category_id'
  ];

export class Section extends Entity {
  id: number = -1;
  planet_id: number = -1;
  category_id: number = -1;

  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}