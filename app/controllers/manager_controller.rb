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

  def information_complete
    @user_name= params[:user][:name]
    @user_password = params[:user][:password]
    @password_confirm = params[:user][:password_confirm]
    @question = params[:user][:question]
    @answer = params[:user][:answer]
    if @user_name!=''&&@user_password!=''&&@password_confirm!=''&&@question!=''&&@answer!=''
      return judge_user_account
    else
      return information_not_complete
    end
  end

  def information_not_complete
    flash[:notice] = "请将注册信息填写完整"
    if session[:current_manager_account]!=nil
      @manager=session[:current_manager_account]
      render '/manager/add_user'
    else
      render '/user/register'
    end
  end

  def judge_user_account
    manager_account = session[:current_manager_account]
    user = User.find_by(name:@user_name)
    if @user_name!=manager_account && user.nil?
      return judge_password_repeat
    else
      return name_repeat
    end
  end

  def name_repeat
    flash[:notice] = "该账号已注册"
    if session[:current_manager_account]!=nil
      @manager=session[:current_manager_account]
      render '/manager/add_user'
    else
      render '/user/register'
    end
  end

  def judge_password_repeat
    if @user_password==@password_confirm
      @user=User.new(user_params)
      @user.save
      return manager_or_user
    else
      return password_not_repeat
    end
  end

  def manager_or_user
    if session[:current_manager_account]!=nil
      redirect_to '/manager/manage_user'
    else
      session[:current_user_account]=params[:user][:name]
      redirect_to '/user/welcome'
    end
  end

  def password_not_repeat
    flash[:notice] = "两次密码输入不一致,请重新输入"
    if session[:current_manager_account]!=nil
      @manager=session[:current_manager_account]
      render '/manager/add_user'
    else
      render '/user/register'
    end
  end

  def destroy
    name= params[:format]
    @user = User.find_by(name:name)
    @user.destroy
    redirect_to manager_manage_user_path
  end

  def manager_modify_password
    @user_name= params[:format]
    @manager=session[:current_manager_account]
  end

  def judge_login
    user_name=params[:format]
    if session[:current_manager_account]!=nil
      return modify_password(user_name)
    else
      redirect_to '/manager/login'
    end
  end

  def modify_password(user_name)
    @user = User.find_by(name:user_name)
    @password = params[:admin][:password]
    @user_password_confirm = params[:admin][:password_confirm]
    if @password != '' && @user_password_confirm !=''
      return password_repeat
    else
      flash[:information]="密码不能为空"
      redirect_to manager_manager_modify_password_path(@user[:name])
    end
  end

  def password_repeat
    if @password==@user_password_confirm
      @user[:password]= @password
      @user[:password_confirm]=@user_password_confirm
      @user.save
      redirect_to "/manager/manage_user"
    else
      flash[:information]="两次密码输入不一致,请重新输入"
      redirect_to manager_manager_modify_password_path(@user[:name])
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
    end
    def admin_params
      params.require(:admin).permit(:password, :password_confirm)
  end

end
