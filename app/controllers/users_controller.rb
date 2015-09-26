class UsersController < ApplicationController
  def index
    @users=User.all
    @search=params[:search]
    render "index"
  end

  def show
    @user_surveys = Survey.where(user_id: params[:id])
    @current_user = User.find(params[:id])
    render "user_profile"
  end
end
