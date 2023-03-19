import { Component, Inject, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { first } from 'rxjs/operators';
import { DOCUMENT } from "@angular/common";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  email = '';
  password = '';
  isLoading = false;
  loading = false;
  submitted = false;
  returnUrl: string;
  error = '';

  constructor(
    @Inject(DOCUMENT)
    private document: Document,
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService
  ) {
    // redirect to home if already logged in
    if (this.authService.currentUserValue) {
      this.router.navigate(['/home']);
    }

  }
  Login() {
  console.log("you are logging in")
    this.authService.login(this.email, this.password)   
  }
 
  async ngOnInit()  {
    this.loginForm = this.fb.group({
        username: ['', Validators.required],
        password: ['', Validators.required]
    });

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
    
    // If we are logging in using AAF then we want to redirect to the AAF login
    await this.authService.loadLoginMethod().then((loadedLoginMethod) => {
      loadedLoginMethod.subscribe((loginMethod) => {
        const { method, redirect_to } = loginMethod;

        if (method == "aaf") {
          this.document.location.href = redirect_to;
        }
      });
    });
  }

  ngAfterViewInit() {
    console.log("ngAfterContentInit", this.authService.loginMethod)
  }

  // convenience getter for easy access to form fields
  get f() { return this.loginForm.controls; }


  //This is a temp solution and does not actually auth the user
  onSubmit() {
    this.submitted = true;
    this.loading = true;
    this.authService.login(this.email, this.password)
      .pipe(first())
      .subscribe(
          data => {
              this.router.navigate(['/intro']);
          },
          error => {
              this.error = error;
              this.loading = false;
          }
        );
  }
}


