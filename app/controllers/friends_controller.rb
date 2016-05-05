class FriendsController < ApplicationController
  before_action :require_login

  def index
    @nav_bar = true
    @all_users = User.all
    @get_friend_reqs = Popular::Friendship.where(friend_id:current_user.id)


    #When one user friends another
    if params[:friend]
		friend = @all_users.find(params[:friend].to_i)
		current_user.befriend friend
		#friend_requests = Popular::Friendship.where(popular_model_id:current_user.id)
	  end

	#When the friend accepts the request
	if params[:accept]
    	Popular::Friendship.find(params[:accept].to_i).update_attribute(:did_accept, true)
        #@friend_shown_array = Popular::Friendship.where(popular_model_id:current_user.id).to_a.clone
    end

    #If friend rejects request
    if params[:reject]
    	User.find(params[:reject].to_i).unfriend current_user
    end

    #Updating all user's friends
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

    #When user wants to remove a friend
    #Need to check who friended who to determine how to remove the friendship
    if params[:remove]
    	if current_user.friends_with? User.find(params[:remove].to_i)
	     	Popular::Friendship.where(popular_model_id:current_user).each do |p|
	     		if User.find(p.friend_id).id == params[:remove].to_i
	     			current_user.unfriend (User.find(params[:remove].to_i))
	     		end
	     	end
	     elsif User.find(params[:remove].to_i).friends_with? current_user
	     	Popular::Friendship.where(popular_model_id:params[:remove].to_i).each do |p|
	     		if User.find(p.friend_id).id == current_user.id
	     			User.find(params[:remove].to_i).unfriend current_user
	     		end
	     	end
		end
    end
  end

  def results
    @nav_bar = true
  	@users = User.all
  	@name = params[:s]

    @results = Array.new

    @users.each do |user|
    	if user.first_name.downcase.include?(@name.downcase) || (user.last_name && user.last_name.downcase.include?(@name.downcase) || user.email.downcase.include?(@name.downcase))
        #First name is required, but last is not
        #Exclude self, exclude if already has person as friend
        if user.id != current_user.id && (!(user.friended_by? current_user) && !(current_user.friended_by?(user)))
          @results.push(user)
        end
      end
    end
  end

  def albums
    @nav_bar = true
    @albums = Album.where(user_id: params[:id], isPublic: true)
    @galleries_viewonly = Array.new
    @galleries_upload = Array.new
    others = Album.where(user_id: params[:id], isPublic: false)
    others.each do |a|
        views = AlbumView.where(album_id: a.id)
        views.each do |v|
          #view_upload_access 0->viewonly, 1->upload+view
          sharables = AlbumView.where(album_view_id: v.album_view_id, user_id: current_user.id)
          if !sharables.blank?
            sharables.each do |sharable|
              if sharable.view_upload_access == 1
                my_album = Album.find(sharable.album_view_id)
                name = a.album_name
                @galleries_upload.push([my_album, name])
              elsif sharable.view_upload_access == 0
                @galleries_viewonly.push(a)
              end
            end
          end
        end
    end
  end
end
