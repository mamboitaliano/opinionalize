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
      @current_user.session_id = session[:session_id]
      @current_user.save!
      redirect_to user_path(@current_user.id)
      
      puts "-- -- -- -- -- -- -- -- -- -- -- -- -- -- \nSession value is" # print out login confirmation to console
      p session[:session_id]
      p "DB session value is "
      p @current_user.session_id
      puts "-- -- -- -- -- -- -- -- -- -- -- -- -- --"
    else
      redirect_to '/'
    end
  end

  def helper_logout
    @current_user = User.find(session[:current_user_id])                  # find current user from sessionb
    if @current_user.session_id != nil                                    # if there is a session_id stored in the database
      @current_user.session_id = nil                                      # set it to 'nil'
    end

    session[:current_user_id] = nil                                       # set session current_user_id value to nil
    session[:session_id] = nil                                            # set session_id to nil

    puts "-- -- -- -- -- -- -- -- -- -- -- -- -- -- \nSession value is"   # print out confirmation to console
    p session[:current_user_id]
    puts "DB session value is "
    p @current_user.session_id
    puts "-- -- -- -- -- -- -- -- -- -- -- -- -- --"
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
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

end
