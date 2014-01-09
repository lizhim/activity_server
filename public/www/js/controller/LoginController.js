function LoginController($scope, $navigate, $http) {
    $scope.login = function () {
        var data = {name: $scope.user_name, password: $scope.user_password}
        $http({method: 'post', url: '/user/login', data: data, type:'json'})
            .success(function(response){
                if(response=='true'){
                    Activity.save_current_user($scope.user_name)
                    $navigate.go("/activity_list")
                }
                if(response=="false"){
                    $scope.notice="true"
                }
            })
            .error(function(response){
            })
    }
}
