class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show]

  helper AlbumsHelper

  def index
	  @nav_bar = true
    # Grab all the albums of the current user
    @albums = Album.where(user_id: current_user.id)

    #albums-views
    #decide who to share albums with
    #then upon choosing a user, create albums-view--> connects album with friend?
  end

  def new
    @album = Album.new
    @users = User.all

  end

  def create
    #Determine public/private access of album
    if params[:opts] == "Public"
      access = true
    elsif params[:opts] == "Private"
      access = false
    end

    # Create a new album where it is tied to the current user
    @album = Album.new(:user_id => current_user.id, :album_name => params[:album_name], :isPublic => access)
    
    #Need to create an album view for each friend
  if params[:friends] 
     #album id stays empty if it's just view access, 
    #if upload is granted, then it will be updated when the friend wants 
    #to add to it - in the friends page (but the permissions will have to be checked)
    
    @owner = AlbumView.new(:user_id => current_user.id)

    params[:friends].each do |f| #right now same permission at once--see if i can change this!
      if params[:access] == "0"
        @album_view = AlbumView.new(:user_id => f, :view_upload_access => 0)
        @album_view.save
      elsif params[:access] == "1"
        @album_view = AlbumView.new(:user_id => f, :view_upload_access => 1)
        @album_view.save
      end
    end
  end


    respond_to do |format|
      if @album.save
        @album_view.update_attribute(:album_view_id, @album.id)
        @owner.update_attribute(:album_id, @album.id) #for owner, album_view_id=album_id
        @owner.update_attribute(:album_view_id, @album.id)
        @owner.update_attribute(:view_upload_access, 1)

        format.html { redirect_to album_path(@album, :friends_shared => params[:friends]), notice: 'Album was successfully created.' }
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
      @friends_shared = params[:friends_shared]

      #If user changes settings
      if params[:opts]
        if params[:opts] == "Public"
          @album.update_attribute(:isPublic, true)
          #Need to delete from album-view...
        elsif params[:opts] == "Private"
          #Need to add to album view
          @album.update_attribute(:isPublic, false)
        end
      end

      #Updates in view
      if @album.isPublic
        @pub_private = "Public"
      else
        @pub_private = "Private"
      end

      #add friends who are shared, and option for adding more friends (in view)
  end

  def edit
    #why is it deleting under edit?????
    #identify the user first...
    # Album.find(params[:id]).destroy
    # redirect_to :action => 'index'
    @album = Album.find(params[:id])
  end

  def update
    puts params
    gets
    if params[:cover]
        @album = Album.find(params[:id])
        @album.update(cover: params[:cover])
        @album.save
    end
    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_path+'/'+ @album.id, notice: 'Cover Updated!!' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
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
