class FriendsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
 
    @all_users = User.all

    @get_friend_reqs = Popular::Friendship.where(friend_id:current_user)



    if params[:friend]


		@friend = @all_users.find(params[:friend])
		friend = @all_users.find(params[:friend].to_i)
														
		@friends = [friend]#@add_friend #params here?
		current_user.befriend friend

		@friendships = Popular::Friendship.where(popular_model_id:current_user.id)

		friend_requests = Popular::Friendship.where(popular_model_id:current_user.id)

		@friend_request_array = Array.new

		if @did_accept
			f.update_attribute(:did_accept, true)
		end

		puts "checking did_accept---------------------------"
		puts @did_accept

		puts "end----------------------------------------------------------"
    	end
  end

  def results
  	@users = User.all
  	@name = params[:s]
  	#@user = User.find(3) #one user to test
  	#@course_result = params[:s]
  	puts "-------------------------"
  	puts params
  	puts params[:s]
  	puts "-------------------------"
  end

end
