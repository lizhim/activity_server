function Activity(activity_name) {
    this.name = localStorage.getItem("user_name")
    this.activity_name = activity_name;
    this.activity_status = "un_start";
}
Activity.prototype.save_activity_name_and_status = function () {
    var activity_array = JSON.parse(localStorage.getItem("activity"));
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
        if (list.name == user_name) {
            return list
        }
        return
    })
    return activity_of_user
}
Activity.get_running_activity_name = function () {
    return localStorage.getItem("running_activity_name");
}
Activity.get_sign_up_person_information = function () {
    return JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name"))) || [];
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
    var activity_array = JSON.parse(localStorage.getItem("activity"));
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
    var activity_array = JSON.parse(localStorage.getItem("activity_of_user"));
    return _.some(activity_array, function (activity) {
        return activity.activity_status == "starting"
    })
}
Activity.number_total = function () {
    var information_array = JSON.parse(localStorage.getItem(localStorage.getItem("now_activity_name"))) || [];
    return information_array.length;
}
Activity.change_status = function (activity_status_temp, status) {
    return activity_status_temp = status;
}