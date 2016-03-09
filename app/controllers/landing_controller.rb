class LandingController < ApplicationController
  def index
    @photos = Photo.all
    @brandeis = Photo.where(:album_id => '666')
    @brandeisLinks = []
    @brandeis.each do |a|
      @brandeisLinks.push(a.url)
    end
  end
end
