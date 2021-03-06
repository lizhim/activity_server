function BidListController($scope, $navigate,$http) {
    $scope.go_to_sign_up_page = function () {
        $navigate.go("/sign_up");
    }
    $scope.bid_lists = BidList.get_bid_information();
    $scope.check_bid_is_start = BidList.check_other_bid_status() == true;
    $scope.go_to_bid_sign_up_page = function () {
        if (BidList.check_other_bid_status() == false) {
            BidList.save_bid_list();
            $navigate.go("/bid_sign_up");
            var bid_array = BidList.get_bid_information();
            localStorage.setItem("biding_name", bid_array[0]["bid_name"]);
        }
        var bid_data = Activity.get_synchronous_data();
        $http({method: "post", url: "/session/synchronous_data", data: bid_data, type: "json"})
            .success(function () {
            })
            .error(function () {
            })
    }
    $scope.go_to_bid_sign_up_information = function (bid_name) {
        $navigate.go("/bid_sign_up");
        BidList.save_bid_name_to_biding_name(bid_name);
    }
    $scope.synchronous = function(){
        synchronous_data($http)
    }
    $scope.synchronous();
}


