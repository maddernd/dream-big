import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StarWizardComponent } from './star-wizard.component';

describe('StarWizardComponent', () => {
  let component: StarWizardComponent;
  let fixture: ComponentFixture<StarWizardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StarWizardComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StarWizardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
