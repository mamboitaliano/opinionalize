class SessionsController < ApplicationController
  def create
    p "^^^^^^^^^^^^^^^^****^^^***^^^**^^**^^*^*^*^*^*^*^*^*^*^*^*^*^"
    p params
    p "^^^^^^^^^^^^^^^^****^^^***^^^**^^**^^*^*^*^*^*^*^*^*^*^*^*^*^"
    
    if params[:provider] = "google_oauth2"
      p "Google OAuth 2.0 starting --------"
      user = User.from_omniauth(env["omniauth.auth"])
      p user
      helper_login(user.username, user.password_hash)
    	# session[:current_user_id] = user.id 	# assign current user id from db to session[:current_user_id]
    	# if session[:session_id] != nil
    	# 	user.session_id = session[:session_id] 	# set user session id in db
    	# 	puts "Session set successfully"
    	# elsif
    	# 	puts "Login error"
    	# end
    elsif params[:provider] = "linkedin"
      p "LinkedIn OAuth 2.0 starting --------"
      redirect_to "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{ENV['CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost%3A9393%2Flogged_in&state=blahblah2&scope=r_basicprofile"
    end
  end

  def destroy
  	session[:current_user_id] = nil
  	redirect_to root_path
  end
end
