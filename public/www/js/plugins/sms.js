var native_accessor = {

    send_sms: function (phone, message) {
        native_access.send_sms({"receivers": [
            {"name": 'name', "phone": phone}
        ]}, {"message_content": message});
    },

    receive_message: function (json_message) {
        if (typeof this.process_received_message === 'function') {
            this.process_received_message(json_message);
        }
    },
    process_received_message: function (json_message) {
        var bid_status_temp = BidList.get_bid_status();
        var activity_status_temp = Activity.get_activity_status();
        var receive_message_front = json_message.messages[0].message.substring(0, 2).toUpperCase();
        if (receive_message_front == "BM") {
            Message.bm (json_message)
            Activity.number_total();
        }
        else if (receive_message_front == "JJ") {
            Message.jj (json_message)
            BidList.bid_number_total();
        }
    }
}

function notify_message_received(message_json) {
    //console.log(JSON.stringify(message_json));
    //JSON.stringify(message_json);
    //alert(JSON.stringify(message_json.messages));
    native_accessor.receive_message(message_json);
    //phone_number=message_json.messages[0].phone;
}

// {"messages":[{"create_date":"Tue Jan 15 15:28:44 格林尼治标准时间+0800 2013","message":"bm仝键","phone":"13611116071"}]}