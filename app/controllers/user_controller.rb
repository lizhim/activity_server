class UserController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

  def register
    @user =User.new
  end

  def judge_password_repeat
    @user =User.new
    @user_password = params[:user][:password]
    @password_confirm = params[:user][:password_confirm]
    if @user_password==@password_confirm
      @user=User.new(user_params)
      if @user.save
        session[:current_user_account]=params[:user][:name]
        redirect_to '/user/welcome'
      else
        render '/user/register'
      end
    else
      @error='password_confirm_not_right'
      render '/user/register'
    end
  end

  def welcome
    @manager=session[:manager]=params[:manager]
    session[:user]=params[:current_user_account]
    @current_user_account=session[:current_user_account]
    if @manager==nil&&@current_user_account!=nil
      @current_user=@current_user_account
      session[:pass_user]= @current_user_account
    end
    if @manager!=nil&&@current_user_account==nil
      @current_user= @manager
      session[:pass_user]=session[:user]
    end
    @activities = Activity.paginate(page: params[:page], per_page: 10).where(:user_name => session[:pass_user])
    @bid=Bid.find_by(:user_name => session[:pass_user], :bid_status => "bid_starting")
  end

  def name_exist_or_not
    @user_name = params[:user][:name]
    user_name = User.find_by(name: @user_name)
    if !user_name.nil?
      session[:current_user_account]=params[:user][:name]
      @user_question=user_name[:question]
      redirect_to user_answer_question_of_password_path(@user_question)
    else
      @error = "name_not_exist"
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
      @error = "answer_not_right"
      render '/user/answer_question_of_password'
    end
  end

  def password_confirm
    @user=User.new()
  end

  def password_consistent
    @user=User.new()
    password = params[:user][:password]
    password_confirm = params[:user][:password_confirm]
    if password==password_confirm
      @current_user = session[:current_user_account]
      @user=User.find_by(name: @current_user)
      @user[:password]=password
      @user[:password_confirm]=password_confirm
      if @user.save
        redirect_to '/user/welcome'
      else
        render '/user/password_confirm'
      end
    else
      @error = "password_confirm_not_right"
      render '/user/password_confirm'
    end
  end

  def login
    password = params[:password]
    user=User.find_by(name: params[:name])
    if user!=nil
      return password_right_or_not(user, password)
    else
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end
  end

  def password_right_or_not(user, password)
    if user[:password] == password
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
    @manager = session[:manager]
    @current_user_account = session[:current_user_account]
    @current_activity=params[:activity_name]
    if @manager==nil&&@current_user_account!=nil
      @current_user=@current_user_account
    end
    if @manager!=nil&&@current_user_account==nil
      @current_user=@manager
    end
    @bids=Bid.paginate(page: params[:page], per_page: 10).where(:user_name => session[:pass_user], :activity_name => @current_activity)
  end

  def sign_up
    @current_user_account=session[:current_user_account]
    @current_activity=params[:activity_name]
    @manager=session[:manager]
    if @manager==nil&&@current_user_account!=nil
      @current_user=@current_user_account
    end
    if @manager!=nil&&@current_user_account==nil
      @current_user=@manager
    end
    @sign_ups=SignUp.paginate(page: params[:page], per_page: 10).where(:user_name => session[:pass_user], :activity_name => @current_activity)
  end

  def bid_detail
    @current_user_account=session[:current_user_account]
    @current_activity=params[:activity_name]
    @current_bid=params[:bid_name]
    @manager=session[:manager]
    if @manager==nil&&@current_user_account!=nil
      @current_user=@current_user_account
    end
    if @manager!=nil&&@current_user_account==nil
      @current_user=@manager
    end
    @bid_details=BidList.paginate(page: params[:page], per_page: 10).where(:user_name => session[:pass_user], :activity_name => @current_activity, :bid_name => @current_bid)
    @bid_winner=Winner.find_by(:user_name => session[:pass_user], :activity_name => @current_activity, :bid_name => @current_bid)
    @price_counts=PriceCount.paginate(page: params[:page], per_page: 10).where(:user_name => session[:pass_user], :activity_name => @current_activity, :bid_name => @current_bid)
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
