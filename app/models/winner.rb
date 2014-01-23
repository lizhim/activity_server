class Winner < ActiveRecord::Base
  def self.winner params
    if params[:bid_winner]!=nil
      Winner.delete_all(:user_name=>params[:user_name])
    end
    params[:bid_winner].each do |t|
      Winner.create(t)
    end
  end
end
