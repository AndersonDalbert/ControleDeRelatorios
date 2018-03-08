import { Component, OnInit, OnDestroy } from '@angular/core';
import { ReportService } from '../../services/report/report.service';
import { Observable } from 'rxjs/Rx';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css']
})
export class ReportComponent implements OnInit {

  private id: any;
  private sub: any;
  public notas_atividade;
  pageTitle = "Relatório de Correção";

  constructor(private _reportService: ReportService, private route: ActivatedRoute) { }

  ngOnInit() {
    this.sub = this.route.params.subscribe(params => {
      this.id = params['id'];
      console.log(this.id);
      this.getReport();
    });
  }

  getReport() {
    this._reportService.getReport(this.id).subscribe(
      data => { this.notas_atividade = data},
      err => console.error(err),
      () => console.log('Done loading report da atividade ')
    );
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

}
