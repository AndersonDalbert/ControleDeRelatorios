angular.module('app').controller('AlunosController',
  function($scope, AlunosService) {
     $scope.alunos = [];

     AlunosService.getAlunos(
       function(response) {
         console.log(response);
         if (response.status == 200) {
           $scope.alunos = response.data;
         } else {
           console.log("Response code different from 200");
           console.log(response);
         }
       },
       function(error) {
         console.log("Failed to retrieve alunos");
         console.log(error);
       }
     )
});

angular.module('app').service('AlunosService',
  function($http) {
    this.getAlunos = function(success, failed) {
      $http.get('http://localhost:3000/alunos').then(success, failed);
    }
});
