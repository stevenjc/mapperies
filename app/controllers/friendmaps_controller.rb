class FriendsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
    #@friends = User.find(Friend.all.sample.friender)
    @friends = Friend.all
  end
end
