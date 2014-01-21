class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

  def synchronous_data
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
end
