class Api::V1::UsersController < Api::V1::BaseController

  def show
    begin
      user = User.find params[:id]
      render json: user.to_json
    rescue
        render :json => { :errors => "Invalid User ID" }, :status => 422
    end
  end

  def index
    users = User.all
    render json: users.to_json
  end
end
