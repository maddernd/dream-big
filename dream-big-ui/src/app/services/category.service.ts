import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { Category } from 'src/app/model/category';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class CategoryService extends CachedEntityService<Category> {
  protected readonly endpointFormat = 'category/:id:';
  public readonly rolloverEndpoint = 'category/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'name',
    'description',
  );
  }
  public override createInstanceFrom(json: any, other?: any): Category {
    return new Category();
  }
}