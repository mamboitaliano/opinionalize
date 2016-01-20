class SessionsController < ApplicationController
  
  def create
    
    if params[:provider] == "google_oauth2"
      p "Google OAuth 2.0 starting ----------------------------------------------------------------"
      user = User.from_omniauth(env["omniauth.auth"])
      p user
      helper_login(user.username, user.password_hash)
    
    elsif params[:provider] == "linkedin"
      @state = "blahblah2"
      if !params.key?(:code)
        p "LinkedIn OAuth 2.0 starting ------------------------------------------------------------"
        redirect_to "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{ENV['LINKEDIN_CLIENT_ID']}&redirect_uri=http%3A%2F%2Flocalhost:3000%2Fauth%2Flinkedin%2Fcallback&state=#{@state}&scope=r_basicprofile%20r_emailaddress"
      else
        p "====> found code"
        @code = params[:code]
        if @state == params[:state] # Compare state values to protect from CSRF attack. If no, throw HTTP 401
          p "====> state check OK"
          api = SessionsHelper::Client.new

          response = HTTParty.post('https://www.linkedin.com/uas/oauth2/accessToken', 
            :body => api.posts(@code), 
            :headers => {"Content-Type" => "application/x-www-form-urlencoded"})

          getLinkedinUser = HTTParty.get('https://www.linkedin.com/v1/people/~:(email-address)', 
            :headers => {'Authorization' => "Bearer #{response.parsed_response['access_token']}"})

          p response.parsed_response
          p "====> access token is #{response.parsed_response['access_token']}"
          p getLinkedinUser
          p getLinkedinUser.parsed_response['person']['first_name']
        else
          p "====> STATE MISMATCH, THROWING HTTP 401"
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
