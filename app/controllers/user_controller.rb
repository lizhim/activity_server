class UserController < ApplicationController
  def register

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
      flash[:notice] = "请将注册信息填写完整"
      render '/user/register'
    end
  end

  def judge_user_account
    user = User.find_by(name:@user_name)
    if user.nil?
      return judge_password_repeat
    else
      flash[:notice] = "该账号已注册"
      render '/user/register'
    end
  end
  def judge_password_repeat
    if @user_password==@password_confirm
      @user=User.new(user_params)
      @user.save
      session[:current_user_account]=params[:user][:name]
      redirect_to '/user/welcome'
    else
      flash[:notice] = "两次密码输入不一致,请重新输入"
      render '/user/register'
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
