import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'section_id',
    'description',
    'status'
  ];

export class Goal extends Entity {
  id: number = -1;
  section_id: number = -1;
  description: string = "";
  status: string = "";

  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}