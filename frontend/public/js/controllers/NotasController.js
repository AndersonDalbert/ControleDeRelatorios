angular.module('app').controller('NotasController',
  function($scope, NotasService) {

    $scope.notas = [];

    NotasService.getNotas(
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
        console.log("Failed to retrieve notas");
        console.log(error);
      }
    )
});

angular.module('app').service('NotasService',
  function($http) {
    this.getNotas = function(success, failed) {
      $http.get('http://localhost:3000/notas').then(success, failed);
    }
});
