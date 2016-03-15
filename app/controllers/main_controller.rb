class MainController < ApplicationController
  before_action :require_login

  def show_map
	@nav_bar = true	
  end
end
