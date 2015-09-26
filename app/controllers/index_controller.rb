class IndexController < ApplicationController
  def index
    render 'index'
  end

  def login
    helper_login(params[:username], params[:password])
  end

  def logout
    helper_logout
  end

  def signup
    helper_signup(params[:username], params[:password])
  end
end
