function BidSignUpController($scope, $navigate) {

    $scope.go_to_bid_list_page = function () {
        $navigate.go("/bid_list");
    }
    $scope.go_to_bid_result_page = function () {
        var bid_status_temp = BidList.get_bid_status();
        if (bid_status_temp == "bid_ending") {
            $navigate.go("/bid_result")
        }
    }
    var bid_status_temp = BidList.get_bid_status();
    $scope.selection = bid_status_temp;

    $scope.bid_begin = function () {
        var bid_status_temp = $scope.selection;
        if (BidList.check_other_bid_status() == false) {
            $scope.selection = "bid_starting";
            BidList.change_bid_status_starting ();
        }
        else if (BidList.check_other_bid_status() == true) {
            alert("已经有正在进行的竞价");
        }
    }
    $scope.bid_end = function () {
        var bid_status_temp = BidList.get_bid_status();
        var confirm = window.confirm("确定要结束本次竞价吗？");
        if (confirm == true) {
            $scope.selection = "bid_ending";
            BidList.change_status(bid_status_temp, "bid_ending");
            Activity.save_null_to_running_activity_name()
            $navigate.go("/bid_result");
            Bid.save_winner()
            BidList.change_bid_status_ending ();
        }
    }

    $scope.date_refresh = function () {
        $scope.bid_number = BidList.bid_number_total()
        $scope.bid_sign_up_peoples = BidList.get_bid_person_information ()
    }
    $scope.date_refresh();
}


