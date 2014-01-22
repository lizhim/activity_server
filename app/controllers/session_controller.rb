class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

  def synchronous_data
    Activity.transaction do
      if params[:activity_information]!=nil
        Activity.delete_all(:user_name=>params[:user_name])
      end
      params[:activity_information].each do |t|
        Activity.create(t)
      end

      if params[:sign_up_list]!=nil
        SignUp.delete_all(:user_name=>params[:user_name])
      end
      params[:sign_up_list].each do |t|
        SignUp.create(t)
      end

      if params[:bid_list]!=nil
        Bid.delete_all(:user_name=>params[:user_name])
      end
      params[:bid_list].each do |t|
        Bid.create(t)
      end

      if params[:bid_winner]!=nil
        Winner.delete_all(:user_name=>params[:user_name])
      end
      params[:bid_winner].each do |t|
        Winner.create(t)
      end

      if params[:bid_detail]!=nil
        BidList.delete_all(:user_name=>params[:user_name])
      end
      params[:bid_detail].each do |t|
        BidList.create(t)
      end

      if params[:bid_count]!=nil
        PriceCount.delete_all(:user_name=>params[:user_name])
      end
      params[:bid_count].each do |t|
        PriceCount.create(t)
      end
    end
    respond_to do |format|
      if judge_synchronous_success=='true'
        format.json { render :json => 'true' }
      else
        format.json { render :json => 'false' }
      end
    end
  end
  def judge_synchronous_success
    if params[:activity_information].length==Activity.where(:user_name=>params[:user_name]).length&&
        params[:sign_up_list].length==SignUp.where(:user_name=>params[:user_name]).length&&
        params[:bid_list].length==Bid.where(:user_name=>params[:user_name]).length &&
        params[:bid_winner].length==Winner.where(:user_name=>params[:user_name]).length &&
        params[:bid_detail].length==BidList.where(:user_name=>params[:user_name]).length&&
        params[:bid_count].length==PriceCount.where(:user_name=>params[:user_name]).length
      return "true"
    end
  end
  def show
    @current_user=session[:current_user_account]
    @bids=Bid.find_by(:user_name=>@current_user,:bid_status=>"bid_starting")
    if @bids!=nil
      @bid_peoples=BidList.paginate(page: params[:page],per_page: 10).where(:user_name=>@current_user, :activity_name=>@bids[:activity_name], :bid_name=>@bids[:bid_name])
    end
    if @bids==nil
      @activity=session[:activity]
      @bid_name=session[:bid_name]
      @winner=Winner.find_by(:user_name=>@current_user, :activity_name=>@activity, :bid_name=>@bid_name)
    end
  end
  def jump
    session[:current_user_account]=params[:current_user]
    @bids=Bid.find_by(:user_name=>session[:current_user_one],:bid_status=>"bid_starting")
    if @bids!=nil
      session[:activity]=@bids[:activity_name]
      session[:bid_name]=@bids[:bid_name]
      redirect_to session_show_path
    end
    if @bids==nil
      redirect_to user_welcome_path
    end

  end
end
