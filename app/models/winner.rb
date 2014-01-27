class Winner < ActiveRecord::Base
  def self.winner winner,user_name
    if winner!=nil
      Winner.delete_all(:user_name=>user_name)
      winner.each do |t|
        Winner.create(t)
      end
    end
  end
end
