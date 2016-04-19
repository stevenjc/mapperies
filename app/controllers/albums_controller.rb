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

      #Adding new friends - same as create
      if params[:friends]
        #puts "----------------------------------------"
        #redirect_to :action => 'create', params[:friends] => params[:friends], params[:access] => params[:access]
        #copied from above:
          params[:friends].each do |f| #right now same permission at once--see if i can change this!
            if params[:access] == "0"
              @album_view = AlbumView.new(:user_id => f, :view_upload_access => 0, :album_view_id => @album.id)
              @album_view.save
            elsif params[:access] == "1"
              @album_view = AlbumView.new(:user_id => f, :view_upload_access => 1, :album_view_id => @album.id)
              @album_view.save
            end
        end
      end

      #Remove friend from AlbumView db
      if params[:unshare]
        AlbumView.where(album_view_id:@album.id).each do |av|
          if av.user_id == params[:unshare].to_i
            av.destroy
          end
        end
      end

      #Update access of a friend already shared with
      if params[:change_access]
        #find album_view and update the access
        puts "111111111111111111111111111"
        AlbumView.where(album_view_id:@album.id).each do |av|
          puts "222222222222222222222222222222222"
          if av.user_id == params[:friend].to_i
            puts av.user_id
            puts params[:change_access]
              if params[:change_access] == "View Only"
                puts "4444444444444444444"
                av.update_attribute(:view_upload_access, 0)
              elsif params[:change_access] == "View and Upload"
                puts "5555555555555555555555555555555"
                av.update_attribute(:view_upload_access, 1)
              end
          end
        end
      end

  end

  def edit
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
