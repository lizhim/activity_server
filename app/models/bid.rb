class Bid < ActiveRecord::Base
  def self.bid params
    if params[:bid_list]!=nil
      Bid.delete_all(:user_name=>params[:user_name])
    end
    params[:bid_list].each do |t|
      Bid.create(t)
    end
  end
end
