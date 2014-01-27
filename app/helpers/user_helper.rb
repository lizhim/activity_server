module UserHelper

  def bid_detail
    if @bid_winner.nil?
      return content_tag(:h3, "活动正在进行中...")
    end
    if !@bid_winner.nil?&&@bid_winner["name"]==''
      return content_tag(:h3, "本次竞价无人胜出")
    end
    if !@bid_winner.nil?&&@bid_winner["name"]!=''
      name='获胜者:'+@bid_winner["name"]
      content_tag(:br)
      price='出价:'+@bid_winner["price"]+'元'
      phone='手机号:'+@bid_winner["phone"]
      content_tag(:h3, name + price + phone)
    end
  end
end
