import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AvatarContainerComponent } from './avatar-container.component';

describe('AvatarComponent', () => {
  let component: AvatarContainerComponent;
  let fixture: ComponentFixture<AvatarContainerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AvatarContainerComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AvatarContainerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
