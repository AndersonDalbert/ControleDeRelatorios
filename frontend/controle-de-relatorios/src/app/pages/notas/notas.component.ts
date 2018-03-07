import { Component, OnInit } from '@angular/core';
import { NotasService } from '../../services/notas/notas.service';
import {Observable} from 'rxjs/Rx';

@Component({
  selector: 'app-notas',
  templateUrl: './notas.component.html',
  styleUrls: ['./notas.component.css']
})
export class NotasComponent implements OnInit {

  public notas;
  constructor(private _notasService: NotasService) { }

  ngOnInit() {
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
