class LandingController < ApplicationController
    
    def show
		respond_to do |format|
    	format.html { render :layout => 'home' }
    end

  end
end
