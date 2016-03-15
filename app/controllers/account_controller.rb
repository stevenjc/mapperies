class AccountController < ApplicationController
  before_action :require_login

  def settings
	@nav_bar = true
  end
end
