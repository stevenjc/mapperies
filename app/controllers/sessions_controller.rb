class SessionsController < ApplicationController
  skip_before_action :authorize
    def new
    end

    def create
        user = User.find_by(name: params[:name])
        if user and user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to "/admin"
        else
            redirect_to "/login", alert: "Invalid user/password comboniation"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to "/landing", notice:'Logged Out'
    end

    def show
        session[:user_id]
    end
end
