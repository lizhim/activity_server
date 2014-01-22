function PriceCountController($scope, $navigate,$http) {
    $scope.go_to_bid_list_page = function () {
        $navigate.go("/bid_list");
    }
    $scope.go_to_bid_result_page = function () {
        $navigate.go("/bid_result")
    }
    $scope.bid_winner = Bid.get_winner();

    $scope.price_counts=Bid.get_group_price()
    $scope.date_refresh = function () {
        $scope.bid_number = BidList.bid_number_total()
    }
    $scope.date_refresh();


}