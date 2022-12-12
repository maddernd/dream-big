import { Component, NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { StarControlComponent } from './Components/StarControl/star-control.component';
import { IntroPageComponent } from './Components/intro-page/intro-page.component';
import { LoginComponent } from './Components/login/login.component';
// import { ProfileComponent } from './Components/profile/profile.component';
// import { StarMapComponent } from './Components/StarMap/star-map.component';
import { AuthGuard } from './services/authguard.service';
// import { HomeComponent } from './Components/home/home.component';
import { SolarSystemComponent } from './Components/SolarSystem/solar-system.component';
import { KonvStarComponent } from './Components/KonvaStar/konv-star.component';
import { PopUpComponent } from './Components/pop-up/pop-up.component';



const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'intro', component: IntroPageComponent },
  // { path: 'profile', canActivate: [AuthGuard], component: ProfileComponent },
  // { path: 'home', component: HomeComponent },
  { path: 'star', component: StarControlComponent },
  // { path: 'star-map', component: StarMapComponent },
  { path: 'solar', component: SolarSystemComponent},
  { path: 'konv-star', component: KonvStarComponent},
  { path: 'pop-up', component: PopUpComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
