class AlbumsController < ApplicationController
  def index
	@nav_bar = true
    @albums = Album.all
  end
end
