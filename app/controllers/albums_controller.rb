class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show, :destroy]

  respond_to :html, :js

  helper AlbumsHelper

  def index
	  @nav_bar = true
    # Grab all the albums of the current user
    @albums = Array.new
    #all albums with name and "hidden" ones
    owned_albums = Album.where(user_id: current_user.id)
    owned_albums.each do |a|
        @albums.push([a, find_album_name(a)])
    end
    # @albums = Album.where(user_id: current_user.id)
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

    #!!!!!#Changed
    #make private albums by default
    access = false;

    #!!!!!#Changed
    # Create a new album where it is tied to the current user

    @album = Album.new(:user_id => current_user.id, :album_name => "Unnamed Album", :isPublic => access)
    #!!!!!#Changed
    @owner = AlbumView.new(:user_id => current_user.id)

    #Need to create an album view for each friend
    if !access && params[:friends]
     #album id stays empty if it's just view access,
    #if upload is granted, then it will be updated when the friend wants
    #to add to it - in the friends page (but the permissions will have to be checked)

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
          #!!!!!#Changed
          #@album_view.update_attribute(:album_view_id, @album.id)
          @owner.update_attribute(:album_id, @album.id) #for owner, album_view_id=album_id
          @owner.update_attribute(:album_view_id, @album.id)
          @owner.update_attribute(:view_upload_access, 1)
        end

        format.html { redirect_to album_path(@album, :friends_shared => params[:friends]), notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
        format.js { render :layout=>false}
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
        format.js {render :layout=>false}
      end
    end
  end



  # Grab all the photos in the current album to show them
  def show
      @nav_bar=true
      @photo = Photo.new
      @album = Album.find(params[:id])
      @album_name = find_album_name(@album)
      @view_only = false

      if @album.user_id != current_user.id
        @is_view = true
        @view_only = true
      else
        @is_view = false
      end
      if @album.album_name.eql?("*empty")
        @is_view = true
      end

      @photos = Photo.where(album_id: params[:id])
      @other_photos = find_all_photos(@album)

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
          AlbumView.first_or_create(:user_id => current_user.id, :view_upload_access => 1, :album_id => @album.id, :album_view_id => @album.id)
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
        AlbumView.where(album_view_id: @album.id).each do |av|
          if av.user_id == params[:friend].to_i
              if params[:change_access] == "View Only"
                av.update_attribute(:view_upload_access, 0)
                Album.where(id: av.album_id, album_name: "*empty", user_id: params[:friend].to_i).destroy_all
                av.update_attribute(:album_id, nil)
              elsif params[:change_access] == "View and Upload"
                av.update_attribute(:view_upload_access, 1)
                sharable = Album.create(album_name: "*empty", user_id: params[:friend].to_i, isPublic: false)
                av.update_attribute(:album_id, sharable.id)
              end
          end
        end
      end

  end

  def edit
    # why is it deleting under edit?????
    # identify the user first...
    # Album.find(params[:id]).destroy
    # redirect_to :action => 'index'
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update(:album_name=> params[:a_name], :defaultx=> params[:xcoord], :defaulty=>params[:ycoord]);


    redirect_to album_form_album_path
     # if @album.save
    #   redirect_to album_form_album_path
    # else
    #   redirect_to album_form_album_path
    # end
  end

  def form
    @album = Album.find(params[:id])
    render :layout => false
  end

  def map
    # Show the navigation bar
      @nav_bar = true

      #declare variables we will return to view
      @unmapped=[];
      @unmapped_album=[];

      #declare local variables
      photo_ids=[];     #ID's of photos to be mapped
      album_ids=[];     #ID's of albums to map
      x_coord=[];       #X-Coordinates matching the order of photo_ids
      y_coord=[];       #Y-Coordinates matching the order of photo_ids
      links=[];         #URL links matching the order of photo_ids
      albums=[];        #ID's of albums matching the order of photo_ids
      color=[];         #index of color outline for the album



      # For each album, push all the photos and links into the arrays
      album = Album.find(params[:id])
      photo_ids = Photo.where(:album_id =>params[:id])
      photo_ids.each do |t|
        #only show unmapped photos that belong to the user
        if (t.x_coord == nil) && (album.user_id==current_user.id)
          @unmapped_album.push(params[:id])
          @unmapped.push(t)
        #ignore unmapped photos of the other users
        elsif (t.x_coord ==nil)
        #For everything else, save the url, coordinates, and which album its from
        else
          links.push(t.image.url)
          x_coord.push(t.x_coord)
          y_coord.push(t.y_coord)
          albums.push(params[:id])
        end
      end


      i =0;
      color_map = Hash.new
      albums.each do |a|
        if (color_map[a]==nil)
          color_map[a]=i;
          color.push(i);
          i=i+1;
        else
          color.push(color_map[a])
        end
      end


      gon.x = x_coord
      gon.y = y_coord
      gon.img = links
      gon.albums = albums
      gon.unmapped = @unmapped
      gon.color = color
  end

  def destroy
    #destroy related records in AlbumView & Album
    views = AlbumView.where(album_id: @album.id)
    if !views.empty?
      views.each do |view|
        uploaders = AlbumView.where(album_view_id: view.album_view_id, view_upload_access: 1)
        if uploaders.size == 1
        #which case all entries in the view should be deleted
          AlbumView.where(album_view_id: view.id).destroy_all
        else
        #only delete THE entry
          AlbumView.where(album_view_id: view.id, view_upload_access: 1, user_id: current_user.id).destroy_all
          if !@album.album_name.eql?("*empty")
            #if this is the name-holder, give the name to the next in album_id
            view_name = @album.album_name
            replacement_id = uploaders.where.not(user_id: current_user.id).first.album_id
            Album.find(replacement_id).update(album_name: view_name)
          end
        end
      end
    end
    #then destroy album itself
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_path}
      format.json { head :no_content }
    end
  end

  # def update
  #   Album.find(params[:id]).update(:album_name=> params[:a_name]);
  #   redirect_to :action => 'show'
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  def find_album_name(album)
    a_ids = Array.new
    if album.album_name.eql?("*empty")
      view = AlbumView.where(album_id: album.id).first
      if !view.nil?
        AlbumView.where(album_view_id: view.album_view_id).each do |v|
          a_ids.push(v.album_id)
        end
      end
      a_ids.each do |a_id|
        if !Album.find(a_id).album_name.eql?( "*empty")
          return Album.find(a_id).album_name
        end
      end
    else
      return album.album_name
    end
  end

  def find_all_photos(album)
    photos = Photo.none
    main_album = Album.where(album_name: find_album_name(album)).first
    view_no = AlbumView.where(album_id: main_album.id).first.album_view_id
    if !view_no.nil?
      AlbumView.where(album_view_id: view_no, view_upload_access: 1).each do |v|
        if v.album_id != album.id
          photos += Photo.where(album_id: v.album_id)
        end
      end
    end
    return photos
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def album_params
    # params.require(:subject).permit(:name, :cover)
  # end
end
