// library module imports
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { MAT_DIALOG_DEFAULT_OPTIONS } from '@angular/material/dialog';

import { NgMaterialModule } from './ng-material/ng-material.module';
import { AppRoutingModule } from './app-routing.module';
// import { AdminModule } from './admin/admin.module';

// service imports
import { CategoryService } from './services/category.service';
import { UserService } from './services/user.service';
import { StudentService } from './services/student.service';
import { AuthService } from './services/auth.service';

// component imports
import { NavbarComponent } from './Components/navbar/navbar.component';
import { StarControlComponent } from './Components/StarControl/star-control.component';
// import { StarComponent } from './Components/Star/star.component';
import { AppComponent } from './app.component';
import { IntroPageComponent } from './Components/intro-page/intro-page.component';
import { TableComponentModule } from './admin/generic/table.component';
// import { StarMapComponent } from './Components/StarMap/star-map.component';
import { StepsComponent } from './Components/Wizard-Assessment/steps/steps.component';
import { StepTemplateComponent } from './Components/Wizard-Assessment/steps-template/steps-template.component';
import { StarWizardComponent } from './Components/Wizard-Assessment/star-wizard/star-wizard.component';
import { CompleteWizardComponent } from './Components/Wizard-Assessment/complete-wizard/complete-wizard.component';
// import { HomeComponent } from './Components/home/home.component';
import { LoginComponent } from './Components/login/login.component';
import { ProfileComponent } from './Components/profile/profile.component';
import { SolarSystemComponent } from './Components/SolarSystem/solar-system.component';
import { KonvStarComponent } from './Components/KonvaStar/konv-star.component';
import { SectionDialogComponent } from './Components/SolarSystem/section-dialog.component';
import { AvatarComponent } from './helpers/avatar/avatar.component';
import { AvatarContainerComponent } from './Components/profile/avatarContainer/avatar-container.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    StarControlComponent,
    // StarComponent,
    IntroPageComponent,
    LoginComponent,
    // StarMapComponent,
    StepsComponent,
    StepTemplateComponent,
    StarWizardComponent,
    CompleteWizardComponent,
    // HomeComponent,
    SolarSystemComponent,
    KonvStarComponent,
    SectionDialogComponent,
    AvatarComponent,
    ProfileComponent,
    AvatarContainerComponent
  ],
  imports: [
    BrowserAnimationsModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    ReactiveFormsModule,
    FormsModule,
    // AdminModule,
    TableComponentModule,
    NgMaterialModule,
    RouterModule.forRoot([
      { path: '', redirectTo: '/login', pathMatch: 'full' },
      { path: 'login', component: LoginComponent },
      { path: 'intro', component: IntroPageComponent },
      { path: 'profile', component: ProfileComponent },
      { path: 'star-wizard', component: StarWizardComponent },
      { path: 'complete', component: CompleteWizardComponent },
    ]),
  ],
  providers: [
    UserService,
    CategoryService,
    AuthService,
    StudentService,
    { provide: MAT_DIALOG_DEFAULT_OPTIONS, useValue: { hasBackdrop: true } },
    // {
    // provide: HTTP_INTERCEPTORS,
    //useClass: AuthInterceptor,
    // multi: true
    //.},
    //AuthService,
    //UserService,
    //AuthGuard,
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
