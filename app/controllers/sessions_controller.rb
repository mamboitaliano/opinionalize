class SessionsController < ApplicationController
  
  def create
    if params[:provider] == "google_oauth2"
      p "Google OAuth 2.0 starting --------"
      user = User.from_omniauth(env["omniauth.auth"])
      p user
      helper_login(user.username, user.password_hash)
    elsif params[:provider] == "linkedin"
      p "LinkedIn OAuth 2.0 starting --------"
      @state = "blahblah2"
      if !params.key?(:code)
        redirect_to "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{ENV['LINKEDIN_CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost:3000%2Fauth%2Flinkedin%2Fcallback&state=#{@state}&scope=r_basicprofile"
      else
        p "FOUND CODE"
        @code = params[:code]
        if @state == params[:state] #If the state values do not match, you are likely the victim of a CSRF attack and you should throw an HTTP 401 error code in response.
          p "STATE CHECK OK"
          api = SessionsHelper::Client.new
          response = HTTParty.post('https://www.linkedin.com/uas/oauth2/accessToken', :body => api.posts(@code), :headers => {"Content-Type" => "application/x-www-form-urlencoded"})
          p response
          p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
          p response.parsed_response['access_token']
        else
          p "STATE MISMATCH, THROWING HTTP 401"
          # throw HTTP 401 error
        end
      end
    else 
      p "uh oh, muy problematico"
    end

  end



  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

end








# session[:current_user_id] = user.id 	# assign current user id from db to session[:current_user_id]
# if session[:session_id] != nil
# 	user.session_id = session[:session_id] 	# set user session id in db
# 	puts "Session set successfully"
# elsif
# 	puts "Login error"
# end
