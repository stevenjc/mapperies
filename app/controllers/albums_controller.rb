class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show]

  def index
	  @nav_bar = true
    # Grab all the albums of the current user
    @albums = Album.where(user_id: current_user.id)
  end

  def new
    @album = Album.new
  end

  def create
    # Create a new album where it is tied to the current user
    @album = Album.new(:user_id => current_user.id, :album_name => params[:album_name])
    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # Grab all the photos in the current album to show them
  def show
      @photo = Photo.new
      @album = Album.find(params[:id])
      @photos = Photo.where(album_id: params[:id])
  end

  def delete
    #identify the user first...
    Album.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def update
    Album.find(params[:id]).update(:album_name=> params[:a_name]);
    redirect_to :action => 'show'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def album_params
    # params.require(:subject).permit(:name, :cover)
  # end
end
