import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { StepModel } from '../../../model/step.model';
import { Observable } from 'rxjs';
import { StepsService } from '../../../services/steps.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-star-wizard',
  templateUrl: './star-wizard.component.html',
  styleUrls: ['./star-wizard.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class StarWizardComponent implements OnInit {

  currentStep: Observable<StepModel>;


  constructor(
    private stepsService: StepsService,
    private router: Router) { }



  ngOnInit(): void {
    this.currentStep = this.stepsService.getCurrentStep();
  }

  onNextStep() {
    if (!this.stepsService.isLastStep()) {
      this.stepsService.moveToNextStep();
    } else {
      this.onSubmit();
    }
  }


  showButtonLabel() {
    return !this.stepsService.isLastStep() ? "" : 'Finish';
  }

  onSubmit(): void {
    this.router.navigate(['/complete']);
  }
}
