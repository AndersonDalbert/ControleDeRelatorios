import { Component, OnInit } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { AlunosService } from '../../services/alunos/alunos.service';
import {Observable} from 'rxjs/Rx';

@Component({
  selector: 'app-alunos',
  templateUrl: './alunos.component.html',
  styleUrls: ['./alunos.component.css']
})

export class AlunosComponent implements OnInit {

  public alunos;
  constructor(private _alunosService: AlunosService) { }

  ngOnInit() {
    this.getAlunos();
  }

  getAlunos() {
    this._alunosService.getAlunos().subscribe(
      data => { this.alunos = data},
      err => console.error(err),
      () => console.log('Done loading alunos ')
    );
  }
}
