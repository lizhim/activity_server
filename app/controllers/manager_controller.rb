class ManagerController < ApplicationController
  def login
    session[:current_user_account]=nil
    flash[:error] = nil
  end

  def judge_manager
    name=params[:user][:name]
    password=params[:user][:password]
    manager = User.find_by_name_and_password name,password
    if !manager.nil?
      return judge_manager_or_user(manager)
    else
      @error = "name_or_password_wrong"
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
    @current_user = session[:current_manager_account]
    @user = User.paginate(page: params[:page],per_page: 10).where(:admin=>nil)
  end

  def add_user
    @current_user = session[:current_manager_account]
    @user =User.new()
  end

  def quit
    if session[:current_manager_account]==nil
      redirect_to '/manager/login'
    else
      redirect_to '/manager/manage_user'
    end
  end

  def whether_login
    @user =User.new()
    if session[:current_manager_account]!=nil
      @current_user=session[:current_manager_account]
       judge_password_repeat
    else
      redirect_to '/manager/login'
    end
  end

  def judge_password_repeat
    @user=User.new(user_params)
    if @user.save
      redirect_to '/manager/manage_user'
    else
      render '/manager/add_user'
    end
  end

  def destroy
    User.destroy params[:format]
    redirect_to manager_manage_user_path
  end

  def manager_modify_password
    @user=User.new()
    @user_name= params[:format]
    @current_user=session[:current_manager_account]
  end

  def judge_login
    @current_user=session[:current_manager_account]
    user_name=params[:format]
    if session[:current_manager_account]!=nil
      return password_repeat(user_name)
    else
      redirect_to '/manager/login'
    end
  end

  def password_repeat(user_name)
    @user = User.find_by(name:user_name)
    @user_name=@user[:name]
    @user[:password]= params[:user][:password]
    @user[:password_confirmation]=params[:user][:password_confirmation]
    if @user.update(user_params)
       redirect_to "/manager/manage_user"
    else
      render '/manager/manager_modify_password'
    end
  end

end
