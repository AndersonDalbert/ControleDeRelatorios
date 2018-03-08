import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from '../pages/home/home.component';
import { AlunosComponent } from '../pages/alunos/alunos.component';
import { CronogramaComponent } from '../pages/cronograma/cronograma.component';
import { NotasComponent } from '../pages/notas/notas.component';
import { ReportComponent } from '../pages/report/report.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent
  },
  {
    path: 'alunos',
    component: AlunosComponent
  },
  {
    path: 'cronograma',
    component: CronogramaComponent
  },
  {
    path: 'notas',
    component: NotasComponent
  },
  {
    path: 'report/:id',
    component: ReportComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
