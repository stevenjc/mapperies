class FriendsController < ApplicationController
  before_action :require_login

  def index
  
	@nav_bar = true
 
    @all_users = User.all

    @get_friend_reqs = Popular::Friendship.where(friend_id:current_user)

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

	@all_friends = Array.new
	@user_friender = Popular::Friendship.where(popular_model_id:current_user)
    @user_friendee = Popular::Friendship.where(friend_id:current_user)
    
    #might need to check if user friender/friendee is null
    @user_friender.each do |f|
    if f.did_accept
    		User.find(f.friend_id).first_name
        	@all_friends.push(User.find(f.friend_id))
    	end
    end
    
    @user_friendee.each do |f|
    	if f.did_accept
            User.find(f.popular_model_id).first_name
            @all_friends.push(User.find(f.popular_model_id))
        end
    end

     if params[:remove]
     	puts "***********************************"
     	puts current_user.first_name
     	puts params[:remove]
     	puts params[:remove].to_i

     	if current_user.friends_with? User.find(params[:remove].to_i)
	     	Popular::Friendship.where(popular_model_id:current_user).each do |p|
	     		puts p.id
	     		puts p.popular_model_id
	     		puts User.find(p.popular_model_id).first_name
	     		if User.find(p.friend_id).id == params[:remove].to_i
	     			current_user.unfriend (User.find(params[:remove].to_i))
	     			#puts "11111111111111111111111111111111111111111111"
	     		end
	     	end
	     elsif User.find(params[:remove].to_i).friends_with? current_user
	     	Popular::Friendship.where(popular_model_id:params[:remove].to_i).each do |p|
	     		#puts "2222222222222222222222222222222222222222222"

	     		if User.find(p.friend_id).id == current_user.id
	     			#puts "2222222222222222222222222222222222222222222"

	     			User.find(params[:remove].to_i).unfriend current_user
	     		end
	     	end
	    # else
	     	#puts "33333333333333333333333333333333333333333333333"
	     end
	     	

     	puts "***********************************"
     	# if !Popular::Friendship.where(popular_model_id:current_user) && 
     	# 	!Popular::Friendship.where(friend_id:params[:remove].to_i)
     	# 	current_user.unfriend (User.find(params[:remove].to_i))
     	# 	puts "11111111111111111111111111111111111111111111"
     	# elsif !Popular::Friendship.where(friend_id:current_user).empty? && 
     	# 	!Popular::Friendship.where(popular_model_id:params[:remove].to_i).empty?
     	# 	User.find(params[:remove].to_i).unfriend current_user
     	# 	#current_user.unfriend (User.find(params[:remove].to_i))
     	# 	puts "2222222222222222222222222222222222222222222222222"
     	# else
     	# 	puts "33333333333333333333333333333333333333333333"

     	# end	
    end
  end

  def results
  	@users = User.all
  	@name = params[:s]
  end

end
