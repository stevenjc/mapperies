class Api::V1::AlbumsController < Api::V1::BaseController

  def show
    begin
      album = Album.where( id: params[:id], user_id: params[:user_id])
      render json: album.to_json
    rescue
      render :json => { :errors => "No Albums Found" }, :status => 422
    end
  end

  def index
    albums = Album.where(user_id: params[:user_id])
    if not albums.empty?
      render json: albums.to_json
    else
      render :json => { :errors => "No Albums Found" }, :status => 422
    end
  end
end
