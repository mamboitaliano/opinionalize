class UsersController < ApplicationController
  def index
    @users=User.all
    @search=params[:search]
    render "index"
  end

  def show
    @current_user = User.find(params[:id])
    
    puts "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
    p @current_user.session_id
    p session[:session_id]
    p params[:id].to_i
    p @current_user.id
    puts "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"
    
    if session[:session_id] != nil  # if session id is not nil, show profile
      if @current_user.session_id == session[:session_id]
        @user_surveys = Survey.where(user_id: @current_user.id)
        render "user_profile"
      else
        render "/errors/403"
      end
    elsif session[:session_id] == nil
      puts "User not logged in"
      render "/errors/404"
    end

  end
end

# to make a survey public, create a field in Surveys table called is_public and allow the user 
# the option to set a survey's privacy to 'public'.
# If a user's survey is public, it can then be accessed by other users by 
# running a check on the db entry on whether is_public == true