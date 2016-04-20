class MainController < ApplicationController
  before_action :require_login

  def index
# Show the navigation bar
  @nav_bar = true


  # Grab all albums owned by this user
  @albums = Album.where(:user_id => current_user.id)
  @id=[];

  @x_coord=[];
  @y_coord=[];
  @links=[];

  @x_coord_default=[];
  @y_coord_default=[];
  @unmapped=[];

  @temp=[];

  # Grab all albums belonging to the user
  @albums.each do |a|
    @id.push(a.id)
  end

  # For each album, push all the photos and links into the arrays
  @id.each do |i|
    @temp = Photo.where(:album_id => Integer(i))
    @temp.each do |t|
      @links.push(t.image.url)
      if t.x_coord == nil
        tempalbum = Album.find(Integer(i))
        @unmapped.push(t)
        @x_coord.push(tempalbum.defaultx)
        @y_coord.push(tempalbum.defaulty)
      else
        @x_coord.push(t.x_coord)
        @y_coord.push(t.y_coord)
      end
    end
  end


  gon.x = @x_coord
  gon.y = @y_coord
  gon.img = @links

  # @brandeisLinks = []
  # @brandeisCoords=[]
  # @brandeis.each do |a|
  #   @brandeisLinks.push(a.url)
  #   @brandeisCoords.push([a.x_coord, a.y_coord])
  # end
  # gon.brandeisCoords= @brandeisCoords
  # gon.brandeis = @brandeis
  end
end
