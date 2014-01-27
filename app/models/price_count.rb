class PriceCount < ActiveRecord::Base
  def self.price_count price_count,user_name
    if price_count!=nil
      PriceCount.delete_all(:user_name=>user_name)
      price_count.each do |t|
        PriceCount.create(t)
      end
    end
  end
end
