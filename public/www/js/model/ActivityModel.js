function Activity(activity_name) {
    this.user_name = localStorage.getItem("user_name")
    this.activity_name = activity_name;
    this.activity_status = "un_start";
}
Activity.prototype.save_activity_name_and_status = function () {
    var activity_array = JSON.parse(localStorage.getItem("activity"))||[];
    activity_array.unshift(this);
    localStorage.setItem("activity", JSON.stringify(activity_array));
}
Activity.save_null_to_running_activity_name = function () {
    localStorage.setItem("running_activity_name", JSON.stringify([]));
}
Activity.save_now_activity_name_to_running_activity_name = function () {
    localStorage.setItem("running_activity_name", Activity.get_now_activity_name());
}
Activity.get_now_activity_name = function () {
    return localStorage.getItem("now_activity_name");
}
Activity.save_activity_name_to_now_activity_name = function (activity_name) {
    return localStorage.setItem("now_activity_name", activity_name);
}
Activity.save_current_user = function (user_name) {
    localStorage.setItem("user_name", user_name)
}
Activity.get_current_user = function () {
    return localStorage.getItem("user_name")
}
Activity.get_activity_of_user = function () {
    var activity = JSON.parse(localStorage.getItem("activity"));
    var user_name = Activity.get_current_user()
    var activity_of_user = _.filter(activity, function (list) {
        if (list.user_name == user_name) {
            return list
        }
    })
    return activity_of_user
}
Activity.get_running_activity_name = function () {
    return localStorage.getItem("running_activity_name");
}
Activity.get_sign_ups = function () {
    return JSON.parse(localStorage.getItem("sign_ups")) || [];
}
Activity.get_sign_up_person_information = function () {
    var sign_ups = JSON.parse(localStorage.getItem("sign_ups"));
    var user_name = Activity.get_current_user()
    return _.filter(sign_ups, function (list) {
        if (list.user_name == user_name && list.activity_name == Activity.get_now_activity_name()) {
            return list
        }
        return
    })
}
Activity.change_activity_status_starting = function () {
    var activity_status_temp = Activity.get_activity_status();
    var activity_array = JSON.parse(localStorage.getItem("activity"));
    var new_activity_array = _.map(activity_array, function (activity) {
        if (activity.activity_name == Activity.get_now_activity_name()) {
            activity.activity_status = Activity.change_status(activity_status_temp, "starting");
        }
        return activity;
    })
    localStorage.setItem("activity", JSON.stringify(new_activity_array));
}
Activity.change_activity_status_ending = function () {
    var activity_status_temp = Activity.get_activity_status();
    var activity_array = JSON.parse(localStorage.getItem("activity"));
    var new_activity_array = _.map(activity_array, function (activity) {
        if (activity.activity_name == Activity.get_now_activity_name()) {
            activity.activity_status = Activity.change_status(activity_status_temp, "ending");
        }
        return activity;
    })
    localStorage.setItem("activity", JSON.stringify(new_activity_array));
}
Activity.activity_name_is_null = function (activity_name) {
    return activity_name == "" || activity_name == null || activity_name == undefined
}
Activity.rename = function (activity_name) {
    var activity_array = Activity.get_activity_of_user();
    var repeat_status = _.some(activity_array, function (activity) {
        return activity.activity_name == activity_name
    })
    return  repeat_status
}
Activity.activity_status_judge_button = function (activities) {
    if (activities != undefined) {
        return _.some(activities, function (activity) {
            return activity.activity_status == "starting"
        })
    }
}
Activity.activity_and_bid_status_judge_button = function (activities) {
    if (activities != undefined) {
        return _.some(activities, function (activity) {
            return activity.activity_status == "ending" && BidList.get_bid_status() == "bid_starting"
        })
    }
}
Activity.get_activity_status = function () {
    var now_activity_name = localStorage.getItem("now_activity_name");
    var activity_array = JSON.parse(localStorage.getItem("activity"));
    var now_activity_status
    now_activity_status = _.find(activity_array, function (num) {
        return num.activity_name == now_activity_name
    });
    if (now_activity_status != undefined) {
        return now_activity_status.activity_status;
    }
}
Activity.check_other_sign_up_status = function () {
    var activity_array = Activity.get_activity_of_user();
    return _.some(activity_array, function (activity) {
        return activity.activity_status == "starting"
    })
}
Activity.number_total = function () {
    var sign_ups = JSON.parse(localStorage.getItem("sign_ups"));
    var information_array = _.filter(sign_ups, function (list) {
        return list.user_name == Activity.get_current_user() && list.activity_name == Activity.get_now_activity_name()
    });
    return information_array.length;
}
Activity.change_status = function (activity_status_temp, status) {
    return activity_status_temp = status;
}
Activity.get_activity_information = function () {
    var activity_information = [];
    var activity = Activity.get_activity_of_user();
    _.map(activity, function (list) {
        var activity_name = list.activity_name
        activity_information.push({"activity_name": list.activity_name, "enrollment": Activity.enrollment(activity_name),
            "bidder": BidList.get_bidder(activity_name)})
    })
    return activity_information
}
Activity.enrollment = function (activity_name) {
    var sign_ups = JSON.parse(localStorage.getItem("sign_ups"));
    var information_array = _.filter(sign_ups, function (list) {
        return list.user_name == Activity.get_current_user() && list.activity_name == activity_name
    });
    return information_array.length;
}
Activity.get_sign_up_information = function () {
    var sign_up_information = [];
    var sign_ups = Activity.get_name_and_phone_of_activity();
    _.each(sign_ups, function (list) {
        if ( list.user_name == Activity.get_current_user()) {
            sign_up_information.push({"activity_name": list.activity_name, "name": list.name, 'phone': list.phone})
        }
    })
    return sign_up_information
}
Activity.get_name_and_phone_of_activity = function () {
    var sign_ups = JSON.parse(localStorage.getItem("sign_ups"));
    var name_and_phone_information = _.filter(sign_ups, function (list) {
        return list.user_name == Activity.get_current_user()
    })
    return name_and_phone_information
}
Activity.get_bid_number = function () {
    var bid_list = [];
    var bid_array = BidList.get_bid_array();
    _.each(bid_array, function (bid) {
        if(bid.user_name==Activity.get_current_user()){
            var bid_name = bid.bid_name;
            var activity_name=bid.activity_name;
            bid_list.push({"activity_name": bid.activity_name, "bid_name": bid.bid_name,
                "bid_number": Activity.number(activity_name,bid_name),"sign_up":Activity.enrollment(activity_name)})
        }
    })
    return bid_list
}
Activity.number = function (activity_name,bid_name) {
    var bid_array = BidList.get_bid_array();
    var bid = _.find(bid_array, function (list) {
        if(list.bid_name== bid_name&&list.activity_name==activity_name){
            return list.biddings
        }
    })
    return bid["biddings"].length
}
Activity.get_bid_detail=function() {
    var bid_detail=[];
    var bid_array = BidList.get_bid_array();
    _.each(bid_array,function(bid){
        _.map(bid.biddings,function(num){
            bid_detail.push({"activity_name":bid.activity_name,"bid_name":bid.bid_name,"name":num.name,
                "price":num.price,"phone":num.phone})
        })
    })
    return bid_detail
}

Activity.get_synchronous_data = function () {
    console.log(Activity.get_bid_detail())
    return {"user_name": Activity.get_current_user(), "activity_information": Activity.get_activity_information(),
        "sign_up_list": Activity.get_sign_up_information(), "bid_list": Activity.get_bid_number(),
        "bid_detail": Activity.get_bid_detail()}
}
