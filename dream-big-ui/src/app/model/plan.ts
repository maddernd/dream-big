import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'section_id',
    'goal_id',
    'plan_text'
  ];

export class Plan extends Entity {
  id: number = -1;
  section_id: number = -1;
  goal_id: number = -1;
  plan_text: string = "";

  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}