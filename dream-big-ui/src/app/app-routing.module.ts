import { Component, NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { StarControlComponent } from './Components/StarControl/star-control.component';
import { IntroPageComponent } from './Components/intro-page/intro-page.component';
import { LoginComponent } from './Components/login/login.component';
import { AuthGuard } from './services/authguard.service';

import { SolarSystemComponent } from './Components/SolarSystem/solar-system.component';
import { KonvStarComponent } from './Components/KonvaStar/konv-star.component';




const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'intro', component: IntroPageComponent },
  // { path: 'profile', canActivate: [AuthGuard], component: ProfileComponent },
  { path: 'star', component: StarControlComponent },
  { path: 'solar', component: SolarSystemComponent},
  { path: 'konv-star', component: KonvStarComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
