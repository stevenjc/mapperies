class Api::V1::AlbumsController < Api::V1::BaseController

  def show
      album = Album.where( id: params[:id], user_id: params[:user_id])
      if not album.empty?
        render json: album.to_json
      else
        render :json => { :errors => "No Album Found" }, :status => 422
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
