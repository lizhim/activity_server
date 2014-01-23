class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

  def synchronous_data
    Activity.transaction do
      Activity.activity params[:activity_information],params[:user_name]
      SignUp.sign_up params[:sign_up_list],params[:user_name]
      Bid.bid params[:bid_list],params[:user_name]
      Winner.winner params[:bid_winner],params[:user_name]
      BidList.bid_list params[:bid_detail],params[:user_name]
      PriceCount.price_count params[:bid_count],params[:user_name]
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
    @bids=Bid.find_by(:user_name=>session[:pass_user],:bid_status=>"bid_starting")
    if @bids!=nil
      @bid_peoples=BidList.paginate(page: params[:page],per_page: 10).where(:user_name=>session[:pass_user], :activity_name=>@bids[:activity_name], :bid_name=>@bids[:bid_name])
    end
    if @bids==nil
      @winner=Winner.find_by(:user_name=>session[:pass_user], :activity_name=>session[:activity], :bid_name=>session[:bid_name])
    end
  end

  def jump
    @bids=Bid.find_by(:user_name=>session[:pass_user],:bid_status=>"bid_starting")
    if @bids!=nil
      session[:activity]=@bids[:activity_name]
      session[:bid_name]=@bids[:bid_name]
      redirect_to '/session/show'
    end
    if @bids==nil
      redirect_to user_welcome_path(current_user_account:session[:pass_user],manager:session[:manager])
    end
  end
end
