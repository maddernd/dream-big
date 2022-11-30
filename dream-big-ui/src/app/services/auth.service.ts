import { Injectable } from '@angular/core';
import { HttpClientModule, HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from "rxjs";
import { Router } from '@angular/router';
import { User } from '../model/user';
import { map } from "rxjs/operators";

@Injectable({
  providedIn: 'root'
})

export class AuthService {

  uri = 'http://localhost:3000';
  token: any;
  private currentUserSubject: BehaviorSubject<User>;
  public currentUser: Observable<User>;

  constructor(private http: HttpClient, private router: Router) {
    this.currentUserSubject = new BehaviorSubject<User>(
      JSON.parse(localStorage.getItem("currentUser"))
    );
    this.currentUser = this.currentUserSubject.asObservable();
  }

  public get currentUserValue(): User {
    return this.currentUserSubject.value;
  }

  login(email: string, password: string) {
    // post to fake back end, this url will be handled there...

    return this.http
      .post<any>(this.uri + '/api/authentication/login', { email: email, password: password })
      .pipe(
        map(user => {
          // store user details and basic auth credentials in local storage to keep user logged in between page refreshes
          user.authdata = window.btoa(email + ":" + password);
          localStorage.setItem("currentUser", JSON.stringify(user));
          this.currentUserSubject.next(user);
          return user;
        })
      );
  }

  logout() {
    // remove user from local storage to log user out
    localStorage.removeItem("currentUser");
    this.currentUserSubject.next(null);
  }

  parseJwt(token:string) {
    var base64Url = token.split('.')[1];
    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    var jsonPayload = decodeURIComponent(window.atob(base64).split('').map(function (c) {
      return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
  };
}

