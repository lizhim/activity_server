function Bid(name, phone, price) {
    this.name = name;
    this.phone = phone;
    this.price = price;
}
Bid.prototype.blank = function () {
    this.price = (this.price).trim();
}
Bid.get_increase_bid_price = function () {
    var bid_result_information_array = JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") +
        localStorage.getItem("biding_name"))) || [];
    var bid_people_information_array = _.sortBy(bid_result_information_array, function (num) {
        return num.price;
    });
    return bid_people_information_array;
}
Bid.get_winner = function () {
    Bid.save_winner()
    var winner_array = JSON.parse(localStorage.getItem("bid_winner"));
    return  winner_array
}
Bid.judge_bid_success = function () {
    var group_by_price = Bid.get_group_price();
    if (group_by_price.length != 0) {
        var bid_person = _.find(group_by_price, function (bid) {
            return bid.number == 1
        })
        if (bid_person != undefined) {
            return bid_person.price
        }
        return false;
    }
    return false
}
Bid.save_winner = function () {
    var bid_people_information_array = Bid.get_increase_bid_price();
    if (Bid.judge_bid_success() != false) {
        var bid_winner= _.find(bid_people_information_array, function (bid) {
            return bid.price == Bid.judge_bid_success ()
        })
        localStorage.setItem("bid_winner", JSON.stringify(bid_winner))
    }
    Bid.save_null_to_winner();
}
Bid.save_null_to_winner=function(){
    if (Bid.judge_bid_success() == false){
        localStorage.setItem("bid_winner", JSON.stringify([]))
    }
}
Bid.get_group_price = function () {
    var bid_people_information_array = Bid.get_increase_bid_price();
    var price_count_infos = _.groupBy(bid_people_information_array, function (num) {
        return num.price
    })
    var price_array = JSON.parse(localStorage.getItem("price_count_array"))
    _.map(price_count_infos, function (value, key) {
        price_array.push({"price": key, "number": value.length})
    })
    return  price_array
}
