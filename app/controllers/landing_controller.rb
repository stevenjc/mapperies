class LandingController < ApplicationController
  def index
    @brandeis = Photo.where(:album_id => '666')
    @brandeisLinks = []
    @brandeisCoords=[]
    @brandeis.each do |a|
      @brandeisLinks.push(a.url)
      @brandeisCoords.push([a.x_coord, a.y_coord])
    end
    gon.brandeisCoords= @brandeisCoords
    gon.brandeis = @brandeis
  end
end
