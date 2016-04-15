class Api::V1::PhotosController < Api::V1::BaseController

  def show
    begin
      photo = Photo.where( id: params[:id], album_id: params[:album_id])
      render json: photo.to_json
    rescue
      render :json => { :errors => "No Photo Found" }, :status => 422
    end
  end

  def index
    photos = Photo.where(album_id: params[:album_id])
    if not photos.empty?
      render json: photos.to_json
    else
      render :json => { :errors => "No Photos Found" }, :status => 422
    end
  end
end
