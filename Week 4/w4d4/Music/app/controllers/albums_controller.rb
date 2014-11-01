class AlbumsController < ApplicationController
  before_action :log_in
  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks
    render :show
  end
  
  def new
    @bands = Band.all
    @band = Band.new
    @album = Album.new
    render :new
  end
  
  def create
    @album = Album.new(name: params[:album][:name], band_id: params[:band][:id])
    @band = @album.band
    @bands = Band.all
    if @album.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    @band = Band.new
    render :edit
  end
  
  def update
    @album = Album.find(params[:id])
    @bands = Band.all
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      @band = Band.new
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    if Album.delete(@album)
      redirect_to band_url(band)
    else
      falsh[:errors] = @album.errors.full_messages
      redirect_to band_url(band)
    end
  end
  
  private
  def album_params
    params.require(:album).permit(:name, :band_id)
  end

end