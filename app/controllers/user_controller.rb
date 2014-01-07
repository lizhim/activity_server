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



  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
