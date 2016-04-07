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

  def save
    params[:user][:first_name] = empty_to_nil params[:user][:first_name]
    params[:user][:last_name] = empty_to_nil params[:user][:last_name]
    params[:user][:user_name] = empty_to_nil params[:user][:user_name]


    current_user.update_attribute(:email, params[:user][:email])
    current_user.update_attribute(:first_name, params[:user][:first_name])
    current_user.update_attribute(:last_name, params[:user][:last_name])
    current_user.update_attribute(:user_name, params[:user][:user_name])
    current_user.update_attribute(:birthday, params[:user][:birthday])
    redirect_to '/account/settings'
  end

  def delete
    @user = current_user
    @user.destroy
    redirect_to '/'
  end

  def empty_to_nil param
    if param == ""
      return nil
    end
  end

end
