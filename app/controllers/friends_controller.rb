class FriendsController < ApplicationController
  def index
    #@friends = User.find(Friend.all.sample.friender)
    @friends = User.all
  end
end
