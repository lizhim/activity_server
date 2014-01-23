class PriceCount < ActiveRecord::Base
  def self.price_count params
    if params[:bid_count]!=nil
      PriceCount.delete_all(:user_name=>params[:user_name])
    end
    params[:bid_count].each do |t|
      PriceCount.create(t)
    end
  end
end
