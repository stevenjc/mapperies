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
     @email = user_params.delete(:email)
     @password = user_params.delete(:password)
     @first_name = user_params.delete(:first_name)
     @last_name = user_params.delete(:last_name)
     @birthday = user_params.delete(:birthday)
     @user_name = user_params.delete(:user_name)



     Clearance.configuration.user_model.new(user_params).tap do |user|
       user.email = @email
       user.password = @password
       user.birthday = @birthday
       if @first_name === ""
           user.first_name = nil
       else
           user.first_name = @first_name
       end
       if @last_name === ""
           user.last_name = nil
       else
           user.last_name = @last_name
       end
       if @user_name === ""
           user.user_name = nil
       else
           user.user_name = @user_name
       end
     end
   end


  def update
    if params[:id]="edit_pic"
      @p = Photo.find(params[:dragphoto])
      @a = Album.find(@p.album_id)
      @u = User.find(@a.user_id)
      if @u=current_user
        puts "passed"
        puts params[:x]
        puts params[:y]
        @p.update_attribute(:x_coord, params[:x])
        @p.update_attribute(:y_coord, params[:y])
      else
        puts "failed"
      end


      redirect_to "/main"
    end
  end

end
