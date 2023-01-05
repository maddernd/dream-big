
import { Component, OnInit } from '@angular/core';
import { Inject } from '@angular/core';
import { DOCUMENT } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { PopUpComponent } from '../pop-up/pop-up.component';

@Component({
  selector: 'app-intro-page',
  templateUrl: './intro-page.component.html',
  styleUrls: ['./intro-page.component.scss']
})
export class IntroPageComponent implements OnInit {

// Sets the number of stars we wish to display
readonly numStars = 100;

// Inject what we need to access the native document variable
constructor(@Inject(DOCUMENT) private document: any,  private router: Router, private dialogRef : MatDialog) { }

ngOnInit() {
  // For every star we want to display
  for (let i = 0; i < this.numStars; i++) {
    // Create a new element
    let star = this.document.createElement("div");
    // Set its style to resemble a star
    star.style.position = "absolute";
    star.style.width = "1px";
    star.style.height = "1px";
    star.style.backgroundColor = "white";
    // Get random positions on the screen and set them
    var xy = this.getRandomPosition();
    star.style.top = xy[0] + 'px';
    star.style.left = xy[1] + 'px';
    // Append our new star
    this.document.getElementById("space").append(star);
  }
  setTimeout(() => {
    this.router.navigate(['/home'])
  }, 100000);
  
}

// Gets random x, y values based on the size of the container
getRandomPosition() {
  var y = window.innerWidth;
  var x = window.innerHeight;
  var randomX = Math.floor(Math.random()*x);
  var randomY = Math.floor(Math.random()*y);
  return [randomX,randomY];
}

openDialog() {
  this.dialogRef.open(PopUpComponent);
}
}