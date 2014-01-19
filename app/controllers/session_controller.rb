class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token, :login

  def synchronous_data
    if params[:activity_information]!=nil
      params[:activity_information].each do |t|
        if Activity.find_by(user_name:t[:user_name],activity_name:t[:activity_name])
        else
          Activity.create(t)
        end
      end
    end
    if params[:sign_up_list]!=nil
      params[:sign_up_list].each do |t|
        if SignUp.find_by(user_name:t[:user_name],activity_name:t[:activity_name],phone:t[:phone])
        else
          SignUp.create(t)
        end
      end
    end
    if params[:bid_list]!=nil
      params[:bid_list].each do |t|
        if Bid.find_by(user_name:t[:user_name],activity_name:t[:activity_name],bid_name:t[:bid_name])
        else
          Bid.create(t)
        end
      end
    end
    if params[:bid_winner]!=nil
      params[:bid_winner].each do |t|
        if Winner.find_by(user_name:t[:user_name],activity_name:t[:activity_name],bid_name:t[:bid_name])
        else
          Winner.create(t)
        end
      end
    end
    if params[:bid_detail]!=nil
      params[:bid_detail].each do |t|
        if BidList.find_by(user_name:t[:user_name],activity_name:t[:activity_name],bid_name:t[:bid_name],phone:t[:phone])
        else
          BidList.create(t)
        end
      end
    end
    if params[:bid_count]!=nil
      params[:bid_count].each do |t|
        if PriceCount.find_by(user_name:t[:user_name],activity_name:t[:activity_name],bid_name:t[:bid_name],price:t[:price])
        else
          PriceCount.create(t)
        end
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
end
