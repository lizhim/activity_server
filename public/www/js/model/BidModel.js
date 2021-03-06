function Bid(name, phone, price) {
    this.name = name;
    this.phone = phone;
    this.price = price;
}
Bid.prototype.blank = function () {
    this.price = (this.price).trim();
}
Bid.get_increase_bid_price = function () {
    var bids = JSON.parse(localStorage.getItem("bids"))
    var biddings = _.find(bids,function(bid){
        return bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()&&bid.bid_name==localStorage.getItem("biding_name")
    })
    var bid_people_information_array = _.sortBy(biddings.biddings, function (list) {
        return Number(list.price);
    });
    return bid_people_information_array;
}
Bid.get_increase_bid_price_ = function (activity_name,bid_name) {
    var bids = JSON.parse(localStorage.getItem("bids"))
    var biddings = _.find(bids,function(bid){
        return bid.user_name==Activity.get_current_user()&&bid.activity_name==activity_name&&bid.bid_name==bid_name
    })
    var bid_people_information_array = _.sortBy(biddings.biddings, function (list) {
        return Number(list.price);
    });
    return bid_people_information_array;
}
Bid.get_winner = function () {
    var winner_array = JSON.parse(localStorage.getItem("bid_winner"));
    return _.find(winner_array,function(list){
        return list.user_name == Activity.get_current_user() && list.activity_name ==Activity.get_now_activity_name()&&list.bid_name==localStorage.getItem("biding_name");
    })
}
Bid.winner=function(){
    var winner_array = JSON.parse(localStorage.getItem("bid_winner"));
    return _.filter(winner_array,function(list){
        return list.user_name == Activity.get_current_user();
    })
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
    var winner=JSON.parse(localStorage.getItem("bid_winner"))
    var bid_people_information_array = Bid.get_increase_bid_price();
    if (Bid.judge_bid_success() != false) {
        var bid_winner= _.find(bid_people_information_array, function (bid) {
            return bid.price == Number(Bid.judge_bid_success ())
        })
        winner.push({"user_name":Activity.get_current_user(),"activity_name": Activity.get_now_activity_name(),
            "bid_name":localStorage.getItem("biding_name"),"name":bid_winner.name,"phone":bid_winner.phone,"price":bid_winner.price})
        localStorage.setItem("bid_winner", JSON.stringify(winner))
    }
    Bid.save_null_to_winner(winner);
}
Bid.save_null_to_winner=function(winner){
    if (Bid.judge_bid_success() == false){
        winner.push({"user_name":Activity.get_current_user(),"activity_name": Activity.get_now_activity_name(),
            "bid_name":localStorage.getItem("biding_name"),"name":'',"phone":'',"price":''})
        localStorage.setItem("bid_winner", JSON.stringify(winner))
    }
}
Bid.get_group_price = function () {
    var bid_people_information_array = Bid.get_increase_bid_price();
    var price_count_infos = _.groupBy(bid_people_information_array, function (num) {
        return Number(num.price)
    })
    var price_array = JSON.parse(localStorage.getItem("price_count_array"))
    _.map(price_count_infos, function (value, key) {
        price_array.push({"price": key, "number": value.length})
    })
    return  price_array
}
