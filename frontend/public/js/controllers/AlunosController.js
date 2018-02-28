angular.module('app').controller('AlunosController',
  function($scope) {

     $scope.alunos = [
      {
        idAluno: "1",
        matricula: "115210091",
        nome: "Anderson Dalbert Carvalho Vital"
      },
      {
        idAluno: "2",
        matricula: "115210001",
        nome: "Jean-Paul Sartre"
      },
      {
        idAluno: "3",
        matricula: "114110666",
        nome: "Friedrich Wilhelm Nietzsche"
      }];
});
