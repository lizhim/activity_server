function BidList(bid_name) {
    this.bid_name = bid_name;
    this.bid_status = "bid_un_start";
    this.biddings = [];
    this.user_name = localStorage.getItem("user_name");
    this.activity_name = localStorage.getItem("now_activity_name");
}
BidList.save_bid_list = function () {
    var bids = JSON.parse(localStorage.getItem("bids"));
    var bid_array=_.filter(bids,function (list) {
        return list.user_name==localStorage.getItem("user_name")&&list.activity_name==Activity.get_now_activity_name();
    })
    var activity_status_temp = Activity.get_activity_status();
    if (activity_status_temp == "ending") {
        var bid_name= "竞价" + (bid_array.length + 1)
        var bid_array_temp=new BidList(bid_name)
        bids.unshift(bid_array_temp);
        localStorage.setItem("bids", JSON.stringify(bids));
    }
}
BidList.get_biding_name = function () {
    return localStorage.getItem("biding_name");
}
BidList.save_bid_name_to_biding_name = function (bid_name) {
    return  localStorage.setItem("biding_name", bid_name);
}
BidList.get_bid_person_information = function () {
    var bids = JSON.parse(localStorage.getItem("bids"))
    var bid_person_information=_.filter(bids, function (bid) {
        return bid.bid_name==BidList.get_biding_name()&&bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()
    })
    return bid_person_information[0].biddings
}
BidList.get_bid_information = function () {
    var bids = JSON.parse(localStorage.getItem("bids"));
    var bid_array=_.filter(bids,function (list) {
        return list.user_name==localStorage.getItem("user_name")&&list.activity_name==Activity.get_now_activity_name();
    })
    return bid_array;
}
BidList.change_bid_status_starting = function () {
    var bid_array = BidList.get_bid_information();
    var bid_status_temp = BidList.get_bid_status();
    var new_bid_array = _.map(bid_array, function (bid) {
        if (bid.bid_name == BidList.get_biding_name()&&bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()) {
            bid.bid_status = BidList.change_status(bid_status_temp, "bid_starting")
        }
        return bid;
    })
    localStorage.setItem("bids" , JSON.stringify(new_bid_array));
}
BidList.change_bid_status_ending = function () {
    var bid_array = BidList.get_bid_information();
    var bid_status_temp = BidList.get_bid_status();
    var new_bid_array = _.map(bid_array, function (bid) {
        if (bid.bid_name == BidList.get_biding_name()&&bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()) {
            bid.bid_status = BidList.change_status(bid_status_temp, "bid_ending")
        }
        return bid;
    })
    localStorage.setItem("bids", JSON.stringify(new_bid_array));
}
BidList.get_bid_status = function () {
    var biding_name = localStorage.getItem("biding_name");
    var bid_array = JSON.parse(localStorage.getItem("bids"));
    var bid_status_of_biding_name = _.find(bid_array, function (bid) {
        return bid.bid_name == biding_name&&bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()
    });
    if (bid_status_of_biding_name != undefined) {
        return  bid_status_of_biding_name.bid_status;
    }
}
BidList.check_other_bid_status = function () {
    var bids = JSON.parse(localStorage.getItem("bids"));
    var biding_name = localStorage.getItem("biding_name");
    var bid_status_of_biding_name = _.filter(bids, function (bid) {
        return bid.user_name==Activity.get_current_user()&&bid.activity_name==Activity.get_now_activity_name()
    });
    return one= _.some(bid_status_of_biding_name , function (bid) {
        return bid.bid_status == "bid_starting"
    })
}
BidList.bid_number_total = function () {
    var bid_information_array = BidList.get_bid_person_information();
    return bid_information_array.length;
}
BidList.change_status = function (bid_status_temp, status) {
    return bid_status_temp = status;
}
BidList.get_bidder = function (activity_name) {
    var bids = JSON.parse(localStorage.getItem("bids"));
    var bid_array=_.filter(bids,function (list) {
        return list.user_name== Activity.get_current_user()&&list.activity_name==activity_name;
    })
    return bid_array.length;
}