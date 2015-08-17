class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in_user, only: [:new]
  before_action :require_authenticated_user, only: [:create, :edit, :update, :destroy]
  def index
    @albums = Albums.find_by(user_id: params[:user_id])
  end

  def show
  end

  def new
    @album = Album.new
  end

  def create
    album = Album.new(album_params)
    album.user = current_user
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
    if @album.update
      redirect_to @album, notice: "Album updated successfully."
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album.destroy
    rediret_to root_path, notice: "Album successfully destroyed"
  end

  private

  def album_params
    params.require(:album).permit(:name, :description, :private_album, :secret_key)
  end

  def set_album
    @album = Album.find_by(id: params[:id])
  end
end
