class FriendsController < ApplicationController
  
  def index
	@nav_bar = true
    #@friends = User.find(Friend.all.sample.friender)
    @friends = User.all
  end
end
