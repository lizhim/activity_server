function BidResultController($scope, $navigate, $timeout,$http) {
    $scope.go_to_bid_list_page = function () {
        $navigate.go("/bid_list")
    }

    $scope.go_to_price_count_page = function () {
        $navigate.go("/price_count")
    }

    $scope.pop_out_modal = true;
    $scope.checked_footer = false;
    $timeout(function () {
        $scope.pop_out_modal = false;
        $scope.checked_footer = true;
    }, 3000);

    $scope.close_modal = function () {
        $scope.pop_out_modal = false;
        $scope.checked_footer = true;
    }

    $scope.bid_results = Bid.get_increase_bid_price ();
    $scope.bid_success = !Bid.judge_bid_success() == false;
    $scope.bid_winner = Bid.get_winner();
    $scope.date_refresh = function () {
        $scope.bid_number = BidList.bid_number_total()
    }
    $scope.date_refresh();


}
