module EvironmentVariables
	class Application < Rails::Application
		config.before_configuration do
			env_file = Rails.root.join("config", 'environment_variables.yaml')

			if File.exists?(env_file)
				YAML.load_file(env_file)[Rails.env].each do |k, v|
					ENV[k.to_s] = v
				end
			end 
		end 
	end
end