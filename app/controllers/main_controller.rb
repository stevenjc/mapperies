class MainController < ApplicationController
  before_action :require_login

  def index
	@nav_bar = true
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

  def mobile
    @nav_bar=true

  end
end
