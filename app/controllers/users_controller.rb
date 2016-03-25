class UsersController < Clearance::UsersController
#include Clearance::Controller
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

helper UsersHelper


  def index
    @users = User.all
    @test = User.find(1)
    @test2 = User.find(2)
    @test.befriend @test2
  end


  def user_from_params
     email = user_params.delete(:email)
     password = user_params.delete(:password)
     first_name = user_params.delete(:first_name)
     last_name = user_params.delete(:last_name)
     birthday = user_params.delete(:birthday)
     user_name = user_params.delete(:user_name)



     Clearance.configuration.user_model.new(user_params).tap do |user|
       user.email = email
       user.password = password
       user.first_name = first_name
       user.last_name = last_name
       user.birthday = birthday
       user.user_name = user_name
     end
   end
end
