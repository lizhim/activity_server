class Activity < ActiveRecord::Base
  def self.activity activity,user_name
    if activity!=nil
      Activity.delete_all(:user_name=>user_name)
      activity.each do |t|
        Activity.create(t)
      end
    end
  end
end
