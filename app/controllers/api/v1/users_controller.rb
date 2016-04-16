class Api::V1::UsersController < Api::V1::BaseController

  def show
    begin
      user = User.find params[:id]
      render json: user.to_json

    end
  end

  def index
    users = User.all
    render json: users.to_json
  end

  def create
    user = User.create!(email: params[:email], password: params[:password], first_name: params[:first_name])
    render json: user.to_json
  end


end
