class BandsController < ApplicationController
  before_action :log_in
  def index
    @bands = Band.all
    render :index
  end
  
  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
    render :show
  end
  
  def new
    @band = Band.new
    render :new
  end
  
  def create
    @band = Band.new(name: params[:band][:name])
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end
  
  def edit
    @band = Band.find(params[:id])
    render :edit
  end
  
  def destroy
    @band = Band.find(params[:id])
    if Band.delete(@band)
      redirect_to bands_url
    else
      falsh[:errors] = @band.errors.full_messages
      redirect_to band_url(@band)
    end
  end
  
end