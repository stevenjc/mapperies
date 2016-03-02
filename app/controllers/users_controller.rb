class UsersController < Clearance::UsersController
include Clearance::Controller
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

  def index
    @users = User.all
  end
end
