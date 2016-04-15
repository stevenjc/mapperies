class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.where(email: params[:session][:email])
    user.authenticate(params[:session][:email],
                      params[:session][:password])
  end
end
