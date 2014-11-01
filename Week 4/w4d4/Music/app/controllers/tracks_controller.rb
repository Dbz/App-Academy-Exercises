class TracksController < ApplicationController
  before_action :log_in
  def show
    @track = Track.find(params[:id])
    # @album = @track.album
    # @band = @album.band
    render :show
  end
  
  def new
    @band = Band.find(params[:band_id])
    @track = Track.new
    @albums = Album.all
    
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    @albums = Album.all
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end
  
  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    @album = Album.new
    render :edit
  end
  
  def update
    @track = Track.find(params[:id])
    @albums = Album.all
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      @album = Album.new
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    if Track.delete(@track)
      redirect_to album_url(album)
    else
      falsh[:errors] = @track.errors.full_messages
      redirect_to album_url(album)
    end
  end
  
  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :description)
  end
  
end