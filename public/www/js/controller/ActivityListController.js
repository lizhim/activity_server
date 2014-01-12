function ActivityListController($scope, $navigate) {
    $scope.go_to_creat_activity_page = function () {
        if ($scope.check_creat_activity_button == false || $scope.check_creat_activity_button == undefined)
            $navigate.go("/creat_activity");
    }
    $scope.go_to_sign_up_information = function (activity_name) {
        $navigate.go("/sign_up");
        Activity.save_activity_name_to_now_activity_name(activity_name);
    }
    $scope.activities = Activity.get_activity_of_user();
    $scope.check_creat_activity_button = Activity.activity_status_judge_button($scope.activities) == true ||
        Activity.activity_and_bid_status_judge_button($scope.activities) == true;

    if (Activity.activity_and_bid_status_judge_button($scope.activities) == true) {
        Activity.save_now_activity_name_to_running_activity_name();
    }
    $scope.change_yellow_name = function (activity_name) {
        var running_activity_name = Activity.get_running_activity_name();
        if ((activity_name == running_activity_name && BidList.get_bid_status() == "bid_starting")) {
            return 'Background-color:yellow';
        }
    }
}



