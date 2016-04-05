
class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photos = Photo.new()
  end

  def create
    @photo = Photo.new(album_id: params[:album_id])
    @album = Album.where(id: params[:album_id])

    if @photo.save
      flash[:notice] = "Successfully uploaded photo"
      redirect_to "@photos"
    else
      flash[:notice] = "Something went wrong when uploading your image"
      render new_album_photo_path
    end
  end

  def edit
    @photos = Photo.find(params[:id])
  end

  def update
    @photos = Photo.find(params[:id])
    if @photos.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo"
      redirect_to @photos
    else
      render :action => 'edit'
    end
  end

  def destroy
    @photos = Photo.find(params[:id])
    @photos.destroy
    flash[:notice] = "Successfully deleted photo"
    redirect_to photos_url
  end

  def photo_params
    params.require(:image).permit(:album_id)
  end
end
