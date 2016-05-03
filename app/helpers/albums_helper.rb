module AlbumsHelper
	def get_friends
		@all_friends = Array.new
		@user_friender = Popular::Friendship.where(popular_model_id:current_user)
	    @user_friendee = Popular::Friendship.where(friend_id:current_user)

	    #might need to check if user friender/friendee is null
	    @user_friender.each do |f|
	    if f.did_accept != nil
	    		User.find(f.friend_id).first_name
	        	@all_friends.push(User.find(f.friend_id))
	    	end
	    end

	    @user_friendee.each do |f|
	    	if f.did_accept != nil
	            User.find(f.popular_model_id).first_name
	            @all_friends.push(User.find(f.popular_model_id))
	        end
	    end
	    return @all_friends
	end

	def sample_photo id
		photo = Photo.where(album_id: id).sample
	end

end
