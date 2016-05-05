class MainController < ApplicationController
  require 'json'
  before_action :require_login
  include AlbumsHelper

  def index
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
    album_names=Hash.new;   #Name of album matching the order of photo_ids
    album_owner=Hash.new;   #Name of Owner of album matching the order of photo_ids
    color=[];         #index of color outline for the album
    color_map= Hash.new;

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
          @unmapped_album.push(i);
        #ignore unmapped photos of the other users
        elsif (t.x_coord ==nil)
        #For everything else, save the url, coordinates, and which album its from
        else
          links.push(t.image.url)
          x_coord.push(t.x_coord)
          y_coord.push(t.y_coord)
          albums.push(Integer(i))
          album_names[Integer(i)]=tempalbum.album_name
          album_owner[Integer(i)]=User.find(tempalbum.user_id).first_name
        end
      end
      i = 0
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
    end

    x=Hash.new
    y=Hash.new
    album_ids=Hash.new

    for i in 0..(links.length)-1
      url = links[i]
      livesite = url.to_s.slice! 'http://s3.amazonaws.com/mapperies/app/public'
      livesite = @livesite== 'http://s3.amazonaws.com/mapperies/app/public'
      x[url]=x_coord[i];
      y[url]=y_coord[i];
      album_ids[url]=albums[i];
    end


    gon.livesite =livesite;

    gon.color_map = JSON.generate(color_map)
    gon.x1 = JSON.generate(x)
    gon.y1 = JSON.generate(y)
    gon.album_ids = JSON.generate(album_ids)

    gon.img = links
    gon.albums = albums
    gon.unmapped = @unmapped.length>0
    gon.color = color
    gon.album_names = album_names
    gon.album_owner = album_owner
    @has_photos= album_ids.length>0
    @show_legend=album_ids.length>2
    gon.show_legend=@show_legend
  end

  def form
    render :layout => false
  end

end
