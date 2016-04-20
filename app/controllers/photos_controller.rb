class PhotosController < ApplicationController
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

  def destroy
    @photos = Photo.find(params[:id])
    @photos.destroy
    flash[:notice] = "Successfully deleted photo"
    redirect_to photos_url
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photos = Photo.find(params[:id])
    if @photos.update(coordinaiton_params)
      flash[:notice] = "Successfully updated photo"
      redirect_to album_path
    else
      render :action => 'edit'
    end
  end

  private
  # def photo_params
    # params.require(:photo).permit(:album_id, :url, :image)
  # end

  def coordinaiton_params
    params.permit(:x_coord, :y_coord)
  end

#coming from the master...
  #
  #

end
