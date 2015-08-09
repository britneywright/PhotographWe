class AlbumController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  def show
  end

  def new
    @album = Album.new
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to album, notice: "Album created successfully!"
    else
      flash[:errors] = album.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def album_params
    params.require(:album).permit(:name, :description, :private_album, :secret_key)
  end

  def set_album
    @album = Album.find_by(id: params[:id])
  end
end
