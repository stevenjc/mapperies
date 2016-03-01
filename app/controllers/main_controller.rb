class MainController < ApplicationController
  def friends
    #@friends = User.find(Friend.all.sample.friender)
    @friends = User.all

  end

  def albums
    @albums = Album.all
  end

  def show_map
  end
end
