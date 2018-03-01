angular.module('app').controller('ReportController',
  function($scope, $routeParams) {
    $scope.atividade = $routeParams.atividadeId;

    $scope.notas_atividade = [
      {
        aluno: "Dan Brown",
        dataEnvio: "18/10/2017 21:07:18",
        passou: "10",
        erros: "2",
        falhas: "1",
        pulados: "3",
        tempo: "0.5",
        nota_testes: "8.0",
        nota_design: "9.4",
        nota_total: "7.2",
        detalhes: "Relatório"
      },
      {
        aluno: "Ptolomeu",
        dataEnvio: "18/10/2017 21:07:18",
        passou: "10",
        erros: "2",
        falhas: "1",
        pulados: "3",
        tempo: "0.5",
        nota_testes: "8.0",
        nota_design: "9.4",
        nota_total: "7.2",
        detalhes: "Relatório"
      }
    ]
    }
);
