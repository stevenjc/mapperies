class FriendsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
    #@friends = User.find(Friend.all.sample.friender)
    #@friends = User.all
    @all_users = User.all
    @test = User.find(3)
    @test2 = User.find(4)
    @test.befriend @test2

    #@friends = Friend.all
  end

  def results
  	@users = User.all
  	@name = params[:s]
  	#@course_result = params[:s]
  end

end
