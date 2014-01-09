function Message(name, phone) {
    this.name = name;
    this.phone = phone;
}
Message.prototype.blank = function () {
    this.name = (this.name).trim();
}
Message.save_phone = function (json_message) {
    return json_message.messages[0].phone;
}
Message.bm = function (json_message) {
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    information_array_temp.blank();
    Message.judge_activity_start_or_not(json_message);
}
Message.check_sign_up_phone_repeat = function (json_message) {
    var information_array = Activity.get_sign_up_person_information();
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    return _.some(information_array, function (information) {
        return information.phone == information_array_temp.phone
    })
}
Message.judge_activity_start_or_not = function (json_message) {
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    var activity_status_temp = Activity.get_activity_status();
    if (localStorage.getItem("now_activity_name") == undefined || localStorage.getItem("now_activity_name")
        == "" || activity_status_temp == "un_start") {
//             native_accessor.send_sms(information_array_temp.phone, "活动报名尚未开始,请稍候!");
        console.log("活动报名尚未开始,请稍候!")
    }
    return Message.judge_activity_end_or_not(json_message);
}
Message.judge_activity_end_or_not = function (json_message) {
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    var activity_status_temp = Activity.get_activity_status();
    if (activity_status_temp == "ending") {
//            native_accessor.send_sms(information_array_temp.phone, "活动已经结束,请勿继续报名!");
        console.log("活动已经结束,请勿继续报名!")
    }
    return Message.judge_has_signed(json_message);
}
Message.judge_has_signed = function (json_message) {
    var activity_status_temp = Activity.get_activity_status();
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    if (Message.check_sign_up_phone_repeat(json_message) == true && activity_status_temp == "starting") {
//            native_accessor.send_sms(information_array_temp.phone, "你已经报名,请勿重复报名!");
        console.log("你已经报名,请勿重复报名!")
    }
    return Message.save_bm_information(json_message);
}
Message.save_bm_information = function (json_message) {
    var activity_status_temp = Activity.get_activity_status();
    var information_array = Activity.get_sign_up_person_information();
    var information_array_temp = new Message(json_message.messages[0].message.substring(2), json_message.messages[0].phone);
    if (information_array_temp.name != "" && Message.check_sign_up_phone_repeat(json_message) == false &&
        localStorage.getItem("now_activity_name") != undefined && localStorage.getItem("now_activity_name")
        != "" && activity_status_temp == "starting") {
        information_array.unshift(information_array_temp);
        localStorage.setItem(localStorage.getItem("now_activity_name"), JSON.stringify(information_array));
        go_to_act_detail_page_by_name_of('demo');
//                native_accessor.send_sms(information_array_temp.phone, "恭喜!报名成功");
        console.log("恭喜!报名成功")
    }
}
Message.jj = function (json_message) {
    var sign_up_activity_name = Activity.get_sign_up_person_information();
    var check_is_sign_up = _.some(sign_up_activity_name, function (bid) {
        return bid.phone == json_message.messages[0].phone
    });
    if (check_is_sign_up == false) {
//        native_accessor.send_sms(bid_information_array_temp.phone, "对不起,您没有报名此次活动!");
        console.log("对不起,您没有报名此次活动!")
    }
    else {
        var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
        Message.judge_bid_start_or_not(json_message);
    }
}
Message.check_bid_phone_repeat = function (json_message) {
    var bid_information_array = BidList.get_bid_person_information();
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    return _.some(bid_information_array, function (bid) {
        return bid.phone == bid_information_array_temp.phone
    })
}
Message.judge_bid_start_or_not = function (json_message) {
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    var bid_status_temp = BidList.get_bid_status();
    if (localStorage.getItem("now_activity_name") + localStorage.getItem("biding_name") == undefined
        || localStorage.getItem("now_activity_name") + localStorage.getItem("biding_name") == "" ||
        bid_status_temp == "bid_un_start") {
//        native_accessor.send_sms(bid_information_array_temp.phone, "对不起,活动尚未开始!");
        console.log("对不起,活动尚未开始!")
    }
    return Message.judge_bid_end_or_not(json_message);
}
Message.judge_bid_end_or_not = function (json_message) {
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    var bid_status_temp = BidList.get_bid_status();
    if (bid_status_temp == "bid_ending") {
//        native_accessor.send_sms(bid_information_array_temp.phone, "对不起,活动已结束!");
        console.log("对不起,活动已结束!")
    }
    return Message.judge_format(json_message);
}
Message.judge_format = function (json_message) {
    var bid_status_temp = BidList.get_bid_status();
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    if (json_message.messages[0].message.substring(2) == "" || isNaN(json_message.messages[0].message.substring(2)) && bid_status_temp == "bid_starting") {
//        native_accessor.send_sms(bid_information_array_temp.phone, "格式不正确,请重发!");
        console.log("格式不正确,请重发!")
    }
    return Message.judge_has_bid(json_message);
}
Message.judge_has_bid = function (json_message) {
    var bid_status_temp = BidList.get_bid_status();
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    if (Message.check_bid_phone_repeat(json_message) == true && bid_status_temp == "bid_starting" && !(json_message.messages[0].message.substring(2) == "" || isNaN(json_message.messages[0].message.substring(2)))) {
//        native_accessor.send_sms(bid_information_array_temp.phone, "您已成功出价,请勿重复出价!");
        console.log("您已成功出价,请勿重复出价!")
    }
    return Message.save_jj_message(json_message);
}
Message.save_jj_message = function (json_message) {
    var bid_information_array = BidList.get_bid_person_information();
    var bid_information_array_temp = Message.save_bid_information_array_temp(json_message);
    var bid_status_temp = BidList.get_bid_status();
    if (localStorage.getItem("biding_name") != "" && Message.check_bid_phone_repeat(json_message) == false &&
        bid_status_temp == "bid_starting" && !(json_message.messages[0].message.substring(2) == "" ||
        isNaN(json_message.messages[0].message.substring(2)))) {
        bid_information_array.push(bid_information_array_temp);
        localStorage.setItem(localStorage.getItem("now_activity_name") +
            localStorage.getItem("biding_name"), JSON.stringify(bid_information_array))
        go_to_act_detail_page_by_name_of('one')
//        native_accessor.send_sms(bid_information_array_temp.phone, "恭喜,您已出价成功!");
        console.log("恭喜,您已出价成功!")
    }
}
Message.save_bid_information_array_temp = function (json_message) {
    var sign_up_activity_name = Activity.get_sign_up_person_information();
    var find_bid_information = new Bid(_.find(sign_up_activity_name,function (bid) {
        return bid.phone == json_message.messages[0].phone
    }).name, json_message.messages[0].phone, json_message.messages[0].message.substring(2));
    return  find_bid_information;
}
