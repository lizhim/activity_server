function CreatActivityController($scope, $navigate) {
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
    }
    $scope.go_to_activity_list_page = function () {
        $navigate.go("/activity_list");
    }
}
