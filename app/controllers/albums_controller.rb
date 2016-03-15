class AlbumsController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
    @albums = Album.all
  end
end
