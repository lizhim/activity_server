class Bid < ActiveRecord::Base
  def self.bid bid,user_name
    if bid!=nil
      Bid.delete_all(:user_name=>user_name)
      bid.each do |t|
        Bid.create(t)
      end
    end
  end
end
