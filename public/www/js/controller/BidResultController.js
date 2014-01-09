function BidResultController($scope, $navigate, $timeout) {
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

    $scope.bid_results = BidList.get_bid_person_information ();
    $scope.bid_success = !Bid.judge_bid_success() == false;
    $scope.bid_winner = Bid.get_winner();
}
