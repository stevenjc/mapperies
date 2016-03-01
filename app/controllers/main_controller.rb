class MainController < ApplicationController
  def friends
  end

  def albums
    @album = Album.all
  end

  def show_map
  end
end
