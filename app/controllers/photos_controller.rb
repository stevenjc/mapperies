class PhotosController < ApplicationController
  require 'exiftool'

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    if params[:images]
      params[:images].each { |image|
        e= Exiftool.new(image.path)
        @photo = Photo.new(album_id: params[:id], url: params[:url], image: image, x_coord:e[:gps_latitude] , y_coord:e[:gps_longitude])
        puts "========================!!!==========================="
        puts e[:gps_longitude]
        puts e[:gps_latitude]
        @photo.save

      }
    end
    respond_to do |format|
      if @photo.save
        format.html { redirect_to albums_path+'/'+(params[:id]), notice: 'Photo Uploaded!' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @photos = Photo.find(params[:id])
  end

  private
  # def photo_params
    # params.require(:photo).permit(:album_id, :url, :image)
  # end

#coming from the master...
  # def edit
  #   @photos = Photo.find(params[:id])
  # end
  #
  def update
    @photos = Photo.find(params[:id])
    if @photos.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo"
      redirect_to @photos
    else
      render :action => 'edit'
    end
  end
  #
  # def destroy
  #   @photos = Photo.find(params[:id])
  #   @photos.destroy
  #   flash[:notice] = "Successfully deleted photo"
  #   redirect_to photos_url
  # end

end
