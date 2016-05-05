class AccountController < ApplicationController
  before_action :require_login

  def settings
    @nav_bar = true
    @user = current_user
    @attribute_not_found_message = "None Listed"
  end

  def edit
    @user = current_user
    @photo=[];
    albums = Album.where(user_id:current_user.id)
    albums.each do |a|
        # @photo.push(Photo.where(album_id: a.id))

        Photo.where(album_id: a.id).each do |p|
          @photo.push(p);
        end
    end
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
    current_user.update_attribute(:avatar_id, params[:user][:avatar_id])
    redirect_to account_settings_url
  end

  def delete
    @user = current_user
    @user.destroy
    redirect_to root_url
  end

  def empty_to_nil param
    if param === ""
      return nil
    else
      param
    end
  end

end
