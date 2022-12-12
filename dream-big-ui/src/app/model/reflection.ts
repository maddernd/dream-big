import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'section_id',
    'goal_id',
    'reflection_text'
  ];

export class Reflection extends Entity {
  id: number = -1;
  section_id: number = -1;
  goal_id: number = -1;
  reflection_text: string = "";
  
  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}