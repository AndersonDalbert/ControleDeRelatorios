import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import {Observable} from 'rxjs/Rx';

const httpOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'application/json' })
};

@Injectable()
export class CronogramaService {

  constructor(private http:HttpClient) { }

  getCronograma() {
    return this.http.get('http://localhost:3000/cronograma');
  }
}
