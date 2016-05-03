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
        @photo = Photo.new(album_id: params[:id], url: params[:url], image: image)
        # puts "========================!!!==========================="
        @photo.save
        url = @photo.image.url(:original)
        # puts @photo.image.url(:original)
        # @photo.save
      }
    end
    respond_to do |format|
      # if @photo.save
      # if all photos are successfully saved ==> how to implement???
      if true
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

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully deleted photo"
    redirect_to album_path(@photo.album_id)
    # puts "photo deleted"
    # gets
  end

  def edit
    puts "Hello"
    @photo = Photo.find(params[:id])
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
