class UsersController < ApplicationController
  def index
    @users=User.all
    @search=params[:search]
    render "index"
  end

  def show
    if session[:current_session_id] != nil
      @user_surveys = Survey.where(user_id: params[:id])
      @current_user = User.find(params[:id])
      render "user_profile"
    else
      puts "User not logged in"
      render "/errors/404"
    end
  end
end
