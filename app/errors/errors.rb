#This list Errors of API
module Errors

	class ErrorsApi < StandardError
		def initialize(msg)
			super
		end
	end

	class ErrorComunication < ErrorsApi	
		
	end

	class ErrorTextLong < ErrorsApi
		
	end

end
