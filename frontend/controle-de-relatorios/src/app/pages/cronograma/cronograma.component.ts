import { Component, OnInit } from '@angular/core';
import { CronogramaService } from '../../services/cronograma/cronograma.service';
import {Observable} from 'rxjs/Rx';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-cronograma',
  templateUrl: './cronograma.component.html',
  styleUrls: ['./cronograma.component.css']
})
export class CronogramaComponent implements OnInit {

  public cronograma;
  constructor(private _cronogramaService: CronogramaService, private titleService: Title) { }

  ngOnInit() {
    this.titleService.setTitle('Cronograma - Programação Funcional UFCG');
    this.getCronograma();
  }

  getCronograma() {
    this._cronogramaService.getCronograma().subscribe(
      data => { this.cronograma = data},
      err => console.error(err),
      () => console.log('Done loading cronograma ')
    );
  }

}
