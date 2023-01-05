import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { Goal } from 'src/app/model/goal';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class GoalService extends CachedEntityService<Goal> {
  protected readonly endpointFormat = 'goals/:id:';
  public readonly rolloverEndpoint = 'goals/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'id',
    'section_id',
    'description',
    'status'
  );
  }
  public override createInstanceFrom(json: any, other?: any): Goal {
    return new Goal();
  }
}