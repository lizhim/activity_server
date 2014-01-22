function SignUpController($scope, $navigate,$http) {
    $scope.go_to_activity_list_page = function () {
        $navigate.go("/activity_list");
    }
    $scope.go_to_bid_list_page = function () {
        var activity_status_temp = Activity.get_activity_status();
        if (activity_status_temp == "ending") {
            $navigate.go("/bid_list");
        }
    }
    var activity_status_temp = Activity.get_activity_status();
    $scope.selection = activity_status_temp;

    $scope.begin = function () {
        if (Activity.check_other_sign_up_status() == false) {
            $scope.selection = "starting";
            Activity.change_status(activity_status_temp, "starting");
            Activity.save_now_activity_name_to_running_activity_name();
            Activity.change_activity_status_starting();
        }
        else if (Activity.check_other_sign_up_status() == true) {
            alert("已有活动正在报名！")
        }
        var bid_data = Activity.get_synchronous_data();
        $http({method: "post", url: "/session/synchronous_data", data: bid_data, type: "json"})
            .success(function () {
                console.log("7")
            })
            .error(function () {
                console.log("8")
            })
    }
    $scope.end = function () {
        var confirm = window.confirm("确定要结束本活动报名吗？");
        if (confirm == true) {
            $scope.selection = "ending";
            Activity.change_status(activity_status_temp, "ending");
            Activity.save_null_to_running_activity_name();
            $navigate.go("/bid_list");
            Activity.change_activity_status_ending();
        }

    }
    $scope.date_refresh = function () {
        $scope.number = Activity.number_total()
        $scope.sign_up_names = Activity.get_sign_up_person_information()
    }
    $scope.date_refresh();

}
