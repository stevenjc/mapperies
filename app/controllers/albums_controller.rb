class AlbumsController < ApplicationController
  before_action :require_login
  before_action :set_album, only: [:show]

  def index
	@nav_bar = true
    @albums = Album.all
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def album_params
    params.require(:subject).permit(:name)
  end
end
