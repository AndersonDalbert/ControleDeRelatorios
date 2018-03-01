angular.module('app').controller('CronogramaController',
  function($scope, CronogramaService) {
     $scope.cronograma = [];

     CronogramaService.getCronograma(
       function(response) {
         console.log(response);
         if (response.status == 200) {
           $scope.cronograma = response.data;
         } else {
           console.log("Response code different from 200");
           console.log(response);
         }
       },
       function(error) {
         console.log("Failed to retrieve cronograma");
         console.log(error);
       }
     )
});

angular.module("app").service(
  'CronogramaService',
  function($http) {
    this.getCronograma = function(success, failed) {
      $http.get('http://localhost:3000/cronograma').then(success, failed);
    }
  }
);
