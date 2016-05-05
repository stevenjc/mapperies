class SessionsController < Clearance::SessionsController
	def new
		redirect_to :controller => "landing", :action => "show"
	end
end