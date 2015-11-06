module QuestionConcern

	extend ActiveSupport::Concern

	included do
		helper_method :current_survey
  	end

  	def current_survey 		# this method will be used to persist the value of the current survey accross controllers
  		
  	end


end