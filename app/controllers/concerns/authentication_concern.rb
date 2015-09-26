module AuthenticationConcern

  extend ActiveSupport::Concern

  included do
    helper_method :login
    helper_method :logout
    helper_method :signup
    helper_method :is_logged_in?
    helper_method :current_user
  end

  def helper_login(username, password)
    @current_user =  User.find_by(username: username)
    if @current_user.password = password
      session[:current_user_id] = @current_user.id
      @current_user.session_id = SecureRandom.hex(8)
      session[:session_id] = @current_user.session_id
      redirect_to user_path(@current_user.id)
    else
      redirect_to '/'
    end
  end

  def helper_logout
    session[:current_user_id] = nil
    session[:session_id] = nil
    @current_user = User.find_by(session_id: params[:session_id])
    @current_user.session_id = nil
    redirect_to '/'
  end

  def helper_signup(username, password)
    @user = User.new(username: username)
    @user.password = password
    @user.save
    helper_login(username, password)
  end

  def is_logged_in?
    session[:current_user_id]
  end

  def current_user
    User.find(session[:current_user_id])
  end

end
