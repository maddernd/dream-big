import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { CategoryQuestion } from 'src/app/model/category_question';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class CategoryQuestionService extends CachedEntityService<CategoryQuestion> {
  protected readonly endpointFormat = 'category_questions/:id:';
  public readonly rolloverEndpoint = 'category_questions/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'id',
    'question',
    'category_id',
  );
  }
  public override createInstanceFrom(json: any, other?: any): CategoryQuestion{
    return new CategoryQuestion();
  }
}