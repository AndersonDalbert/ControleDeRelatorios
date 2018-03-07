import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import {Observable} from 'rxjs/Rx';

const httpOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'application/json' })
};

@Injectable()
export class NotasService {

  constructor(private http:HttpClient) { }

  getNotas() {
    return this.http.get('http://localhost:3000/notas');
  }
}
