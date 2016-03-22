class AccountController < ApplicationController
  before_action :require_login

  def settings
	@nav_bar = true
    @user = current_user
    @attribute_not_found_message = "None Listed"
  end

  def edit
    @user = current_user
  end

end
