class SessionsController < ApplicationController
  def create
  	user = User.from_omniauth(env["omniauth.auth"])
  	session[:current_user_id] = user.id
  	redirect_to root_path
  end

  def destroy
  	session[:current_user_id] = nil
  	redirect_to root_path
  end
end
