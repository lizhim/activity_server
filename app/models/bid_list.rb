class BidList < ActiveRecord::Base
  def self.bid_list params
    if params[:bid_detail]!=nil
      BidList.delete_all(:user_name=>params[:user_name])
    end
    params[:bid_detail].each do |t|
      BidList.create(t)
    end
  end
end
