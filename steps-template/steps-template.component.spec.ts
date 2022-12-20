import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StepsTemplateComponent } from './steps-template.component';

describe('StepsTemplateComponent', () => {
  let component: StepsTemplateComponent;
  let fixture: ComponentFixture<StepsTemplateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StepsTemplateComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StepsTemplateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
