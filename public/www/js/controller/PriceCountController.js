function PriceCountController($scope, $navigate) {
    $scope.go_to_bid_list_page = function () {
        $navigate.go("/bid_list");
    }
    $scope.go_to_bid_result_page = function () {
        $navigate.go("/bid_result")
    }
    $scope.bid_winner = Bid.get_winner();

    $scope.price_counts=Bid.get_group_price()
}