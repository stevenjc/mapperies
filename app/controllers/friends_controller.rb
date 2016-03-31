class FriendsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
 
    @all_users = User.all

    @get_friend_reqs = Popular::Friendship.where(friend_id:current_user)

    @user_friender = Popular::Friendship.where(popular_model_id:current_user)
    @user_friendee = Popular::Friendship.where(friend_id:current_user)

    if params[:accept]
    	puts Popular::Friendship.find(params[:accept].to_i)
    	Popular::Friendship.find(params[:accept].to_i).update_attribute(:did_accept, true)
    	puts Popular::Friendship.find(params[:accept].to_i)

    end

    if params[:friend]


		@friend = @all_users.find(params[:friend])
		friend = @all_users.find(params[:friend].to_i)
														
		@friends = [friend]#@add_friend #params here?
		current_user.befriend friend

		@friendships = Popular::Friendship.where(popular_model_id:current_user.id)

		friend_requests = Popular::Friendship.where(popular_model_id:current_user.id)

		@friend_request_array = Array.new

	end
  end

  def results
  	@users = User.all
  	@name = params[:s]
  end

end
