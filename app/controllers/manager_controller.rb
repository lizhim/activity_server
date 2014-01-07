class ManagerController < ApplicationController
  def login
    session[:current_user_account]=nil
  end
  def judge_manager
    name=params[:user][:name]
    password=params[:user][:password]
    manager = User.find_by_name_and_password name,password
    if !manager.nil?
      return judge_manager_or_user(manager)
    else
      flash[:error] = "用户名或密码错误"
      render '/manager/login'
    end
  end
  def judge_manager_or_user(manager)
    if manager[:admin]=="true"
      session[:current_manager_account]= params[:user][:name]
      redirect_to '/manager/manage_user'
    else
      session[:current_user_account]= params[:user][:name]
      redirect_to '/user/welcome'
    end
  end

  def logout
    session[:current_manager_account]= nil
    redirect_to '/manager/login'
    flash[:error] = nil
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
    end

end
