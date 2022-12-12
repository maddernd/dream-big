import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { Assessment } from 'src/app/model/assessment';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class AssessmentService extends CachedEntityService<Assessment> {
  protected readonly endpointFormat = 'assessments/:id:';
  public readonly rolloverEndpoint = 'assessments/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'id',
    'journey_id',
    'category_id'
  );
  }
  public override createInstanceFrom(json: any, other?: any): Assessment{
    return new Assessment();
  }
}