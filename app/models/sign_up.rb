class SignUp < ActiveRecord::Base
  def self.sign_up params
    if params[:sign_up_list]!=nil
      SignUp.delete_all(:user_name=>params[:user_name])
    end
    params[:sign_up_list].each do |t|
      SignUp.create(t)
    end
  end
end
