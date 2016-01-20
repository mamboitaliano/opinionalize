module SessionsHelper
	
	class Client
		include HTTParty
		base_uri "https://www.linkedin.com"

	    def initialize
	    end

	    def posts(code)
	        options = {
	          grant_type: "authorization_code",
	          client_id: ENV['LINKEDIN_CLIENT_ID'],
	          redirect_uri: "http://localhost:3000/auth/linkedin/callback",
	          client_secret: ENV['LINKEDIN_CLIENT_SECRET'],
	          code: code
	          }
	        options
	    end
	end

end
