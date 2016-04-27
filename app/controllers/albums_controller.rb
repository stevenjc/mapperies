class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show]

  respond_to :html, :js

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
    # if params[:opts] == "Public"
    #   access = true
    # elsif params[:opts] == "Private"
    #   access = false
    # end

    #make private albums by default
      access = false;


    # Create a new album where it is tied to the current user
    @album = Album.new(:user_id => current_user.id, :album_name => "Unnamed Album", :isPublic => access)

    #Need to create an album view for each friend
  if !access && params[:friends] 
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
        if !access
          @album_view.update_attribute(:album_view_id, @album.id)
          @owner.update_attribute(:album_id, @album.id) #for owner, album_view_id=album_id
          @owner.update_attribute(:album_view_id, @album.id)
          @owner.update_attribute(:view_upload_access, 1)
        end
        
        format.html { redirect_to album_path(@album, :friends_shared => params[:friends]), notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
        format.js { render :layout=>false}
      else
        puts "===========================!!!=========================="
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
        format.js {render :layout=>false}
      end
    end
  end



  # Grab all the photos in the current album to show them
  def show
      @photo = Photo.new
      @album = Album.find(params[:id])
      @photos = Photo.where(album_id: params[:id])
      @friends_shared = params[:friends_shared]

      #If user changes pub/private settings
      if params[:opts]
        if params[:opts] == "Public"
          @album.update_attribute(:isPublic, true)
          #Delete from album view database
          AlbumView.where(album_view_id:@album.id).each do |av|
            av.destroy #make sure this is what I want to be doing...
          end
        elsif params[:opts] == "Private"
          @album.update_attribute(:isPublic, false)
          #Create for owner - selected friends, if any, are added below
          AlbumView.new(:user_id => current_user.id, :view_upload_access => 1, :album_id => @album.id, :album_view_id => @album.id)
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
        AlbumView.where(album_view_id:@album.id).each do |av|
          if av.user_id == params[:friend].to_i
              if params[:change_access] == "View Only"
                av.update_attribute(:view_upload_access, 0)
              elsif params[:change_access] == "View and Upload"
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
    @album = Album.find(params[:id])
    @album.update(:album_name=> params[:a_name], :defaultx=> params[:xcoord], :defaulty=>params[:ycoord]);

    if @album.save
      redirect_to :action => 'show'
    else
      redirect_to :action => 'show'
    end


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
