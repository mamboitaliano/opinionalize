OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, '764318299533-dks7chdnfm82ue120ipi383v84gr5ltb.apps.googleusercontent.com', 'PQYjRseGryHbCtAuORoDOt18', {access_type: 'online', client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end