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
  def welcome
    @current_user=session[:current_user_account]
  end
  def name_exist_or_not
    @user_name = params[:user][:name]
    user_name = User.find_by(name:@user_name)
    if !user_name.nil?
      session[:current_user_account]=params[:user][:name]
      @user_question=user_name[:question]
      redirect_to user_answer_question_of_password_path(@user_question)
    else
      flash[:error] = "账号不存在"
      render '/user/input_name'
    end
  end

  def answer_question_of_password
    @user_question= params[:format]
  end

  def answer_right_or_not
    @user_question = params[:format]
    user_answer = params[:user][:answer]
    user = User.find_by(question:@user_question)
    @user_answer = user[:answer]
    if @user_answer == user_answer
      redirect_to '/user/password_confirm'
    else
      flash[:error] = "忘记密码答案错误"
      render '/user/answer_question_of_password'
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
