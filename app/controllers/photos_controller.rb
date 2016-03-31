class PhotosController < ApplicationController
  def index
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(album_id: params[:id], url: params[:photo][:url], image: params[:photo][:image])
    #db_attr: params[:something]

    puts @photo.image.url(:med)
    puts @photo.album_id
    puts @photo.image
    gets

    respond_to do |format|
      if @photo.save
        format.html { redirect_to new_photo_path, notice: 'Photo Uploaded!' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def photo_params
    params.require(:photo).permit(:album_id, :url, :image)
  end

end
