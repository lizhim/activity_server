function BidList(bid_name) {
    this.bid_name = bid_name;
    this.bid_status = "bid_un_start";
}
BidList.save_bid_list = function () {
    var bid_array = JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") + "竞价")) || [];
    var bid_array_temp = {};
    var activity_status_temp = Activity.get_activity_status();
    if (activity_status_temp == "ending") {
        bid_array_temp.bid_name = "竞价" + (bid_array.length + 1);
        bid_array_temp.bid_status = "bid_un_start";
        bid_array.unshift(bid_array_temp);
        localStorage.setItem(localStorage.getItem("now_activity_name") + "竞价", JSON.stringify(bid_array));
    }
}
BidList.get_biding_name=function(){
    return localStorage.getItem("biding_name");
}
BidList.save_bid_name_to_biding_name=function(bid_name){
    return  localStorage.setItem("biding_name", bid_name);
}
BidList.get_bid_person_information =function(){
    return JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") + localStorage.getItem("biding_name"))) || [];
}
BidList.get_bid_information=function(){
    return JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") + "竞价")) || [];
}
BidList.change_bid_status_starting = function () {
    var bid_array = BidList.get_bid_information();
    var bid_status_temp = BidList.get_bid_status();
    var new_bid_array = _.map(bid_array, function (bid) {
        if(bid.bid_name == BidList.get_biding_name()){
            bid.bid_status=BidList.change_status(bid_status_temp, "bid_starting")
        }
        return bid;
    })
    localStorage.setItem(localStorage.getItem("now_activity_name") + "竞价", JSON.stringify(new_bid_array));
}
BidList.change_bid_status_ending = function () {
    var bid_array = BidList.get_bid_information();
    var bid_status_temp = BidList.get_bid_status();
    var new_bid_array = _.map(bid_array, function (bid) {
        if(bid.bid_name == BidList.get_biding_name()){
            bid.bid_status=BidList.change_status(bid_status_temp, "bid_ending")
        }
        return bid;
    })
    localStorage.setItem(localStorage.getItem("now_activity_name") + "竞价", JSON.stringify(new_bid_array));
}
BidList.get_bid_status = function () {
    var biding_name = localStorage.getItem("biding_name");
    var bid_array = JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") + "竞价")) || [];
    var bid_status_of_biding_name ;
    bid_status_of_biding_name= _.find(bid_array,function (num) {
        return num.bid_name == biding_name
    });
    if(bid_status_of_biding_name!=undefined) {
        return  bid_status_of_biding_name.bid_status;
    }
}
BidList.check_other_bid_status = function () {
    var bid_array = JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name") + "竞价")) || [];
    return _.some(bid_array, function (bid) {
        return bid.bid_status == "bid_starting"
    })
}
BidList.bid_number_total = function () {
    var bid_information_array = BidList.get_bid_person_information();
    return bid_information_array.length;
}
BidList.change_status=function(bid_status_temp,status){
    return bid_status_temp=status ;
}