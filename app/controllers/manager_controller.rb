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
  def manage_user
    @manager = session[:current_manager_account]
    @user = User.paginate(page: params[:page],per_page: 10).where(:admin=>nil)
  end
  def logout
    session[:current_manager_account]= nil
    redirect_to '/manager/login'
    flash[:error] = nil
  end
  def add_user
    @manager = session[:current_manager_account]
  end
  def quit
    if session[:current_manager_account]==nil
      redirect_to '/manager/login'
    else
      redirect_to '/manager/manage_user'
    end
  end
  def whether_login
    if session[:current_manager_account]!=nil
      return information_complete
    else
      redirect_to '/manager/login'
    end
  end

  def destroy
    name= params[:format]
    @user = User.find_by(name:name)
    @user.destroy
    redirect_to manager_manage_user_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
    end

end
