class UsersController < Clearance::UsersController
#include Clearance::Controller
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

  def index
    @users = User.all
  end


  def user_from_params
     email = user_params.delete(:email)
     password = user_params.delete(:password)
     first_name = user_params.delete(:first_name)
     last_name = user_params.delete(:last_name)
     birthday = user_params.delete(:birthday)


     Clearance.configuration.user_model.new(user_params).tap do |user|
       user.email = email
       user.password = password
       user.first_name = first_name
       user.last_name = last_name
       user.birthday = birthday
     end
   end
end
