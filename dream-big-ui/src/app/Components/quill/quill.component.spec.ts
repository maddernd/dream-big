import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QuillComponent } from './quill.component';

describe('QuillComponent', () => {
  let component: QuillComponent;
  let fixture: ComponentFixture<QuillComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ QuillComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(QuillComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
