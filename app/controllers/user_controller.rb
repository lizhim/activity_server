class UserController < ApplicationController
  def register

  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirm, :question, :answer, :admin)
  end
end
