import { Component, OnInit } from '@angular/core';
import { NotasService } from '../../services/notas/notas.service';
import { Observable } from 'rxjs/Rx';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-notas',
  templateUrl: './notas.component.html',
  styleUrls: ['./notas.component.css']
})
export class NotasComponent implements OnInit {

  public notas;
  constructor(private _notasService: NotasService, private titleService: Title) { }

  ngOnInit() {
    this.titleService.setTitle('Notas - Programação Funcional UFCG');
    this.getNotas();
  }

  getNotas() {
    this._notasService.getNotas().subscribe(
      data => { this.notas = data},
      err => console.error(err),
      () => console.log('Done loading notas ')
    );
  }

}
