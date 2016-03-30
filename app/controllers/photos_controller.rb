class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def show
    @photos = Photo.find(params[:id])
  end

  def new
    @photos = Photo.new
  end

  def create
    @photos = Photo.new(params[:image])
    if @photos.save
      flash[:notice] = "Successfully uploaded photo"
      redirect_to @photos
    else
      render :action => "new"
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
    params.require(:image)
  end
end
