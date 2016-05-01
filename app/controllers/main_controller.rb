class MainController < ApplicationController
  before_action :require_login

  def index
# Show the navigation bar
  @nav_bar = true




  #declare local variables
  friend_ids = [];  #Id's of friends whose albums we will map
  photo_ids=[];     #ID's of photos to be mapped
  album_ids=[];     #ID's of albums to map
  x_coord=[];       #X-Coordinates matching the order of photo_ids
  y_coord=[];       #Y-Coordinates matching the order of photo_ids
  links=[];         #URL links matching the order of photo_ids

  @hash = Hash.new

  @x_coord_default=[];
  @y_coord_default=[];
  @unmapped=[];

  

  # Grab all album_ids of the user
  Album.where(:user_id => current_user.id).each do |a|
    album_ids.push(a.id)
  end

  # For each album, push all the photos and links into the arrays
  album_ids.each do |i|
    photo_ids = Photo.where(:album_id => Integer(i))
    photo_ids.each do |t|
      if t.x_coord == nil
        tempalbum = Album.find(Integer(i))
        @unmapped.push(t)
        x_coord.push(tempalbum.defaultx)
        y_coord.push(tempalbum.defaulty)
      else
        links.push(t.image.url)
        x_coord.push(t.x_coord)
        y_coord.push(t.y_coord)
      end
    end
  end


  gon.x = x_coord
  gon.y = y_coord
  gon.img = links

  end

  def form
    render :layout => false
  end
end
