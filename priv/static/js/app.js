app = angular.module('repeatex', []);

app.config(function($httpProvider) {
  $httpProvider.interceptors.push(function($q) {
    return {
      'request': function(config) {
        NProgress.start();
        return config;
      },
      'requestError': function(rejection) {
        NProgress.done();
        return $q.reject(rejection);
      },
      'response': function(response) {
        NProgress.done();
        return response;
      },
      'responseError': function(rejection) {
        NProgress.done();
        return $q.reject(rejection);
      }
    };
  });
});

app.controller('MainController', function($scope, $http) {
  $scope.updateOutput = function() {
    $http.get('/api?description=' + $scope.description).then(function (response) {
      $scope.output = response.data;
    });
    $scope.issueTitle = 'Parse Issue: "' + $scope.description + '"';
    $scope.issueBody = "The description \"" + $scope.description + "\" was supposed to be parsed properly, but wasn't.";
  };

  $scope.goToDemo = function () {
    element = $('input.large');
    $('html, body').animate({
        scrollTop: element.offset().top
    }, 800);
    element.focus();
  };
});
