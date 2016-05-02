class MainController < ApplicationController
  before_action :require_login
  include AlbumsHelper

  def index
# Show the navigation bar
  @nav_bar = true

  #declare variables we will return to view
  @unmapped=[];


  #declare local variables
  photo_ids=[];     #ID's of photos to be mapped
  album_ids=[];     #ID's of albums to map
  x_coord=[];       #X-Coordinates matching the order of photo_ids
  y_coord=[];       #Y-Coordinates matching the order of photo_ids
  links=[];         #URL links matching the order of photo_ids
  albums=[];        #ID's of albums matching the order of photo_ids
  color=[];         #index of color outline for the album

  #grab all the albums of friends who have shared them
  AlbumView.where(:user_id =>current_user.id).each do |d|
    #make sure its not the users album to prevent repeats
    if d.album_id!=d.album_view_id
      album_ids.push(d.album_view_id)
    end
  end

  # Grab all album_ids of the user
  Album.where(:user_id => current_user.id).each do |a|
    album_ids.push(a.id)
  end


  # For each album, push all the photos and links into the arrays
  album_ids.each do |i|
    photo_ids = Photo.where(:album_id => Integer(i))
    photo_ids.each do |t|
      tempalbum = Album.find(Integer(i))
      #only show unmapped photos that belong to the user
      if (t.x_coord == nil) && (tempalbum.user_id==current_user.id)
        @unmapped.push(t)
      #ignore unmapped photos of the other users
      elsif (t.x_coord ==nil)
      #For everything else, save the url, coordinates, and which album its from
      else
        links.push(t.image.url)
        x_coord.push(t.x_coord)
        y_coord.push(t.y_coord)
        albums.push(Integer(i))
      end
    end
  end

  i =1;
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

  def form
    render :layout => false
  end
end
