class LandingController < ApplicationController
  def index
    @photos = Photo.all
    @brandeis = Photo.where(:album_id => '666')
    @brandeisLinks = []
    @brandeisCoords=[]
    @brandeis.each do |a|
      @brandeisLinks.push(a.url)
      @brandeisCoords.push("{lat:#{a.x_coord}, lng:#{a.y_coord}}" )
    end
    gon.brandeisCoords= @brandeisCoords
  end
end
