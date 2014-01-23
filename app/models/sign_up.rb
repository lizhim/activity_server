class SignUp < ActiveRecord::Base
  def self.sign_up sign_up,user_name
    if sign_up!=nil
      SignUp.delete_all(:user_name=>user_name)
    end
    sign_up.each do |t|
      SignUp.create(t)
    end
  end
end
