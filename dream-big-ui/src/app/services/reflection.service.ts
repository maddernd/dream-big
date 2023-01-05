import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { Reflection } from 'src/app/model/reflection';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class ReflectionService extends CachedEntityService<Reflection> {
  protected readonly endpointFormat = 'reflections/:id:';
  public readonly rolloverEndpoint = 'reflections/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'id',
    'section_id',
    'goal_id',
    'reflection_text'
  );
  }
  public override createInstanceFrom(json: any, other?: any): Reflection {
    return new Reflection();
  }
}