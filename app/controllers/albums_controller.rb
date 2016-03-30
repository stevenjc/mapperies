class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show]

  def index
	@nav_bar = true
    @albums = Album.where(user_id: current_user.id)
  end

  def show
      @album = Album.find(params[:id])
      @photos = Photo.where(album_id: params[:id])
  end

  def new
    @album = Album.new(:user_id => current_user.id, :album_name => "New York")
  end

  def create
    @album = Album.new(:user_id => current_user.id, :album_name => "New York")

    if @album.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def delete
    Album.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end


end
