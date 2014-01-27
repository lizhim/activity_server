class BidList < ActiveRecord::Base
  def self.bid_list bid_list,user_name
    if bid_list!=nil
      BidList.delete_all(:user_name=>user_name)
      bid_list.each do |t|
        BidList.create(t)
      end
    end
  end
end
