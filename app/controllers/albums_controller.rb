class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :upload, :destroy]
  before_action :require_logged_in_user, only: [:new]
  before_action :require_authenticated_user, only: [:edit, :destroy]
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
      if params[:photographs]
        @photographs = []
        params[:photographs].each do |source|
          photograph = album.photographs.new(source: source)
          if current_user
            photograph.uploader = current_user
          end
          if photo.save
            @photographs << photo.id
          end
        end
        redirect_to personalize_album_photographs_path(album,photo_ids_string)
      else
        redirect_to album, notice: "Album created successfully!"
      end
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
    @album.delete
    rediret_to root_path, notice: "Album successfully destroyed"
  end

  private

  def album_params
    params.require(:album).permit(:name, :description, :slug, :private_album, :secret_key, photographs_attributes: [:source])
  end

  def set_album
    @album = Album.find_by(slug: params[:id])
  end
end
