import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CachedEntityService, Entity, EntityMapping } from 'ngx-entity-service';
import API_URL from 'src/app/config/constants/apiURL';
import { Answer } from 'src/app/model/answer';

export type IloStats = {
  median: number;
  lower: number;
  upper: number;
  min: number;
  max: number;
}[];

@Injectable()
export class AnswerService extends CachedEntityService<Answer> {
  protected readonly endpointFormat = 'answers/:id:';
  public readonly rolloverEndpoint = 'answers/:id:/rollover';

  constructor(
    httpClient: HttpClient,
  ) {
    super(httpClient, API_URL);
  
  this.mapping.addKeys(
    'id',
    'category_question_id',
    'assessment_id',
    'answer'
  );
  }
  public override createInstanceFrom(json: any, other?: any): Answer{
    return new Answer();
  }
}