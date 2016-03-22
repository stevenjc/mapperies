class PhotosController < ApplicationController
  def index
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(album_id: params[:album_id], url: params[:url])
    #db_attr: params[:something]
    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_path, notice: 'Photo Uploaded!' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def image_params
  end
  
end
