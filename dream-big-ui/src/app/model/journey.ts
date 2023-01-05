import { Entity } from 'ngx-entity-service';

const KEYS =
  [
    'id',
    'student_id'
  ];

export class Journey extends Entity {
  id: number = -1;
  student_id: number = -1;

  /**
   * Indicates that the Unit has yet to be stored in the database
   */
  public get isNew(): boolean {
    return this.id === -1;
  }
}