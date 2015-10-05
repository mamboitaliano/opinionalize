class SessionsController < ApplicationController
  def create
  	user = User.from_omniauth(env["omniauth.auth"])
  	helper_login(user.username, user.password_hash)
  	# puts "---------------------------------------"
  	# p user
  	# session[:current_user_id] = user.id 	# assign current user id from db to session[:current_user_id]
  
  	# if session[:session_id] != nil
  	# 	user.session_id = session[:session_id] 	# set user session id in db
  	# 	puts "Session set successfully"
  	# elsif
  	# 	puts "Login error"
  	# end

  	# p user
  	# puts "---------------------------------------"
  end

  def destroy
  	session[:current_user_id] = nil
  	redirect_to root_path
  end
end
