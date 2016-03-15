class LandingController < ApplicationController
    
    def show
		if signed_in?
			redirect_to '/main'
		#	@nav_bar = true
		end
    end
end
