class LoginController < ApplicationController
	def login
		@nav_bar = true
		redirect_to '/sign_in'
	end

end
