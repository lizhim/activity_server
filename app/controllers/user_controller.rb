class UserController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

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
    user = User.find_by(name: @user_name)
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
    @activities = Activity.paginate(page: params[:page],per_page: 10).where(:user_name=>@current_user)
  end

  def name_exist_or_not
    @user_name = params[:user][:name]
    user_name = User.find_by(name: @user_name)
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
    user = User.find_by(question: @user_question)
    @user_answer = user[:answer]
    if @user_answer == user_answer
      redirect_to '/user/password_confirm'
    else
      flash[:error] = "忘记密码答案错误"
      render '/user/answer_question_of_password'
    end
  end

  def password_confirm

  end

  def password_empty_or_not
    password = params[:user][:password]
    password_confirm = params[:user][:password_confirm]
    if password!=''&&password_confirm!=''
      return password_consistent(password, password_confirm)
    else
      flash[:error] = "密码不能为空"
      render '/user/password_confirm'
    end
  end

  def password_consistent(password, password_confirm)
    if password==password_confirm
      @current_user = session[:current_user_account]
      @user=User.find_by(name: @current_user)
      @user[:password]=password
      @user[:password_confirm]=password_confirm
      @user.save
      redirect_to '/user/welcome'
    else
      flash[:error] = "两次密码答案不一致，请重新输入"
      render '/user/password_confirm'
    end
  end

  def login
    password = params[:password]
    user=User.find_by(name: params[:name])
    if user!=nil
      return password_right_or_not(user,password)
    else
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end
  end

  def password_right_or_not(user,password)
    if user[:password]==password
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end
  end

  def bid_list
    @current_user=session[:current_user_account]
    @current_activity=params[:format]
    @bids=Bid.paginate(page:params[:page],per_page: 10).where(:user_name=>@current_user,:activity_name=>@current_activity)
  end

  def sign_up
    @current_user=session[:current_user_account]
    @current_activity=params[:format]
    @sign_ups=SignUp.paginate(page:params[:page],per_page:10).where(:user_name=>@current_user,:activity_name=>@current_activity)
  end

  def bid_detail
    @current_user=session[:current_user_account]
    @current_activity=params[:activity_name]
    @current_bid=params[:bid_name]
    @bid_details=BidList.paginate(page:params[:page],per_page:10).where(:user_name=>@current_user,:activity_name=>@current_activity,
                                                                      :bid_name=>@current_bid)
    @bid_winner=Winner.find_by(:user_name=>@current_user, :activity_name=>@current_activity, :bid_name=>@current_bid)
    @price_counts=PriceCount.paginate(page:params[:page],per_page:10).where(:user_name=>@current_user,:activity_name=>@current_activity)
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
