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

  #def information_complete
  #  @user_name= params[:user][:name]
  #  @user_password = params[:user][:password]
  #  @password_confirm = params[:user][:password_confirm]
  #  @question = params[:user][:question]
  #  @answer = params[:user][:answer]
  #  if @user_name!=''&&@user_password!=''&&@password_confirm!=''&&@question!=''&&@answer!=''
  #    return judge_user_account
  #  else
  #    flash[:notice] = "请将注册信息填写完整"
  #    @manager=session[:current_manager_account]
  #    render '/manager/add_user'
  #  end
  #end
  #
  #def judge_user_account
  #  manager_account = session[:current_manager_account]
  #  user = User.find_by(name:@user_name)
  #  if @user_name!=manager_account && user.nil?
  #    return judge_password_repeat
  #  else
  #    flash[:notice] = "该账号已注册"
  #    @manager=session[:current_manager_account]
  #    render '/manager/add_user'
  #  end
  #end

  def judge_password_repeat
    @user_password = params[:user][:password]
    @password_confirm = params[:user][:password_confirm]
    if @user_password==@password_confirm
      @user=User.new(user_params)
      if @user.save
        redirect_to '/manager/manage_user'
      else
        render '/manager/add_user'
      end
    else
      @error='password_confirm_not_right'
      render '/manager/add_user'
    end
  end

  def destroy
    name= params[:format]
    @user = User.find_by(name:name)
    @user.destroy
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

  #def modify_password(user_name)
  #  @user = User.find_by(name:user_name)
  #  @password = params[:admin][:password]
  #  @user_password_confirm = params[:admin][:password_confirm]
  #  if @password != '' && @user_password_confirm !=''
  #    return password_repeat
  #  else
  #    @error='password_empty'
  #    #flash[:information]="密码不能为空"
  #    @user_name=@user[:name]
  #    render '/manager/manager_modify_password'
  #  end
  #end

  def password_repeat(user_name)
    @user = User.find_by(name:user_name)
    @user_name=@user[:name]
    @password = params[:admin][:password]
    @user_password_confirm = params[:admin][:password_confirm]
    if @password==@user_password_confirm
      @user[:password]= @password
      @user[:password_confirm]=@user_password_confirm
      if @user.save
         redirect_to "/manager/manage_user"
      else
        render '/manager/manager_modify_password'
      end
    else
      @error='password_confirm_not_right'
      render '/manager/manager_modify_password'
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
