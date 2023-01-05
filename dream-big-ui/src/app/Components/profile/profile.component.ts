import { Component, ElementRef, EventEmitter, Input, OnInit, Output, ViewChild } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { CommonModule } from '@angular/common';

import { User } from 'src/app/model/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

import { AuthGuard } from 'src/app/services/authguard.service';
import { Journey } from 'src/app/model/journey';
import { JourneyService } from 'src/app/services/journey.service';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
  loading = false;
  journey: Journey[];
  users: User[];

  greetings = true;

    constructor(private userService: UserService, private router: Router, private authService: AuthService){

    }
    ngOnInit() {
    this.loading = true;
      this.userService.query().pipe(first()).subscribe(users => {
          this.loading = false;
          this.users = users;
      });
    //   this.jouney.query().pipe(first()).subscribe(journey=> {
    //     this.loading = false;
    //     this.journey= journey;
    // });
  }

  onLogOut() {
    this.loading = true;
    setTimeout(() => {
      this.router.navigate(['/login']);
    }, 1000)
    localStorage.removeItem('loggedIn');
  }
}