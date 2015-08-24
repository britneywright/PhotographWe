class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :upload, :destroy]
  before_action :require_logged_in_user, only: [:new]
  before_action :require_authenticated_user, only: [:edit, :destroy]

  def index
    @albums = Album.where(user_id: current_user.id)
  end

  def show
    if @album.private_album? && !authorized
      redirect_to album_access_path(@album)
    end
  end

  def access
    @album = Album.find_by(slug: params[:album_id])
  end

  def grant_access
    @album = Album.find_by(slug: params[:album_id])
    session["album#{@album.id}".to_sym] = params["album#{@album.id}".to_sym]
    if authorized
      redirect_to @album
    else
      flash[:errors] = ["Invalid Key"]
      redirect_to root_path
    end
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
          if photograph.save
            @photographs << photograph.id
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

  def authorized
    authenticated_user || session["album#{@album.id}".to_sym] == @album.secret_key
  end
end
