class FriendsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
    #@friends = User.find(Friend.all.sample.friender)
    #@friends = User.all
    @all_users = User.all


    @get_friend_reqs = Popular::Friendship.where(friend_id:current_user)

    #@test = User.find(3)
    #@test2 = User.find(4)
    #@test.befriend @test2

    
    #puts "pppppppppppppppppppppppppppppppppppppp"
    #puts @friends
    #puts params[:s]
    #puts params
    #puts params[:friend]
    #puts @friends == nil
   # if params[:friend]
    	#puts @test.first_name
    	#params[:friend].first_name
    #	    puts @all_users.find(params[:friend].to_i)

    #end
  #  puts "ppppppppppppppppppppppppppppppppppppp"
    
   # @friends = Array.new
   # if params[:friend]
    #	friend = @all_users.find(params[:friend].to_i)
    #	@friends.push(friend)
    #end
	#if @friends == nil 
		if params[:friend]
				@friend = @all_users.find(params[:friend]) #the user who's page
				friend = @all_users.find(params[:friend].to_i)
																#to display request on!!
	    		@friends = [friend]#@add_friend #params here?
	    		current_user.befriend friend

				@friendships = Popular::Friendship.where(popular_model_id:current_user.id)

				puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

				puts "current user: #{current_user.id} #{current_user.first_name}"
				@p = Popular::Friendship.where(popular_model_id:current_user.id)
				@p.each do |u|
					puts "#{u.friend_id}"
				end
				puts ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
				friend_requests = Popular::Friendship.where(popular_model_id:current_user.id)
	
				@friend_request_array = Array.new
				friend_requests.each do |f|
					#display this instead of what's in the view now!
					@friend_request_array.push(User.find(f.friend_id))
					puts "this is the friend_request:"
					puts f
					puts "this is the friend's first name:"
					puts User.find(f.friend_id).first_name
				end
#################
				#when user clicks on accept friend request
				@did_accept = false
				if @did_accept
					f.update_attribute(:did_accept, true)
				end

				#puts u.where(friend_id:current_user)
				puts ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
				#puts User.find(u).first_name
				puts "and then "
				u2 = Popular::Friendship.where(friend_id:friend)[0]
				#puts User.find(u).first_name

				puts "all friendships:"
				#puts User.find(Popular::Friendship.where(id:current_user)[0]).first_name
				#puts User.find(Popular::Friendship.where(friend_id:friend)[0]).first_name

				#puts Popular::Friendship.where(friend_id:friend)
				#puts Popular::Friendship.find(u)

				#puts User.where(first_name:"testing2")[0].first_name
				#puts User.find(User.where(first_name:"testing2").first_name)

				puts User.find(current_user).first_name
				#puts Popular::Friendship.where(friend_id:friend)
				puts User.find(friend).first_name
				puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

				#puts User.where(id:current_user)
#				puts User.find(Popular::Friendship.where(id:friend)).id

	    		#puts current_user.friends_with? friend
	    		#puts friend.friends_with? current_user
	    		#puts "1"
	    		#puts @friendships.where(friend_id:current_user.id)
	    		#puts "2"
	    		#puts @friendships.where(friend_id:current_user.id)
	    		####end
    		#else
    		#	@friendshps.push(Popular::Friendship.where(id:friend))
    		#end

    		puts "this is where @did accept will go---------------------------"
    		puts @did_accept

    		puts "end----------------------------------------------------------"
    	end
    #else
    #	@friends.push(friend)
   # end
    #@friends = Friend.all
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
