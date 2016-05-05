class ApplicationController < ActionController::Base
    skip_before_action :avatar, :except => [:landing_controller]
    include Clearance::Controller
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    layout "application"

    def avatar
    	if current_user.avatar_id
    		@avatar= Photo.find(current_user.avatar_id)
    	else
    		nil
    	end
  	end

end
