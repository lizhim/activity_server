function CreatActivityController($scope, $navigate,$http) {
    $scope.disabled = true;
    $scope.prompt_of_repeat = false;
    $scope.creat_activity = function () {
        if (Activity.activity_name_is_null($scope.activity_name)) {
            $scope.disabled = true;
            return;
        }
        $scope.prompt_of_repeat = Activity.rename($scope.activity_name) == true;
        if (Activity.rename($scope.activity_name) == false) {
            var activity = new Activity($scope.activity_name).save_activity_name_and_status();
            $navigate.go("/sign_up");
            Activity.save_activity_name_to_now_activity_name ($scope.activity_name)
        }
        var bid_data = Activity.get_synchronous_data();
        $http({method: "post", url: "/session/synchronous_data", data: bid_data, type: "json"})
            .success(function () {
                console.log("5")
            })
            .error(function () {
                console.log("6")
            })
    }
    $scope.go_to_activity_list_page = function () {
        $navigate.go("/activity_list");
    }
    $scope.list_change=function(){
        if($scope.activity_name!=null){
            $scope.disabled = false;
        }
    }


}
