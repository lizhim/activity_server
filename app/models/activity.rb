class Activity < ActiveRecord::Base
  def self.activity params
    if params[:activity_information]!=nil
      Activity.delete_all(:user_name=>params[:user_name])
    end
    params[:activity_information].each do |t|
      Activity.create(t)
    end
  end
end
