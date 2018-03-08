import { NgModule } from '@angular/core';
import { BrowserModule, Title } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './core/app-routing.module';

import { AlunosService } from './services/alunos/alunos.service';
import { CronogramaService } from './services/cronograma/cronograma.service';
import { NotasService } from './services/notas/notas.service';
import { ReportService } from './services/report/report.service';

import { AppComponent } from './app.component';
import { HomeComponent } from './pages/home/home.component';
import { AlunosComponent } from './pages/alunos/alunos.component';
import { CronogramaComponent } from './pages/cronograma/cronograma.component';
import { NotasComponent } from './pages/notas/notas.component';
import { ReportComponent } from './pages/report/report.component';


@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AlunosComponent,
    CronogramaComponent,
    NotasComponent,
    ReportComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule
  ],
  providers: [
    Title,
    AlunosService,
    CronogramaService,
    NotasService,
    ReportService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
