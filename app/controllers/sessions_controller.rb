class SessionsController < ApplicationController
  def create
  	user = User.from_omniauth(env["omniauth.auth"])
  	puts "---------------------------------------"
  	session[:current_user_id] = user.id
  	p user
  	puts "---------------------------------------"
  	redirect_to root_path
  end

  def destroy
  	session[:current_user_id] = nil
  	redirect_to root_path
  end
end
