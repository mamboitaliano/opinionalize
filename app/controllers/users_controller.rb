class UsersController < ApplicationController
  def index
    @users=User.all
    @search=params[:search]
    render "index"
  end

  def show
    @current_user = User.find(params[:id])
    puts "{{{{{{{{{}}}}}}}}}{{{{{{{{{}}}}}}}}"
    p session[:session_id]
    if session[:session_id] != nil
      @user_surveys = Survey.where(user_id: params[:id])
      @current_user = User.find(params[:id])
      render "user_profile"
    elsif session[:session_id] == nil
      puts "User not logged in"
      render "/errors/404"
    end

  end
end
