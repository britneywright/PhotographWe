class PhotographsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:album_id])
    @photograph = Photograph.find_by(id: params[:id])
  end

  def new
    @album = Album.find_by(id: params[:album_id])
    @photograph = Photograph.new
  end

  def create
    album = Album.find_by(id: params[:album_id])
    photograph = album.photographs.new(photograph_params)
    if current_user
      photograph.uploader = current_user
    end
    if photograph.save
      redirect_to album_photograph_path(album.id, photograph.id)
    else
      flash[:errors] = photograph.errors.full_messages
      redirect_to album
    end
  end

  def upload
    @album = Album.find_by(id: params[:album_id])
  end

  def add
    @album = Album.find_by(id: params[:album_id])
    if params[:photographs]
      params[:photographs].each do |source|
        @album.photographs.create(source: source)
      end
    end
    redirect_to @album
  end

  private

  def photograph_params
    params.require(:photograph).permit(:source, :caption)
  end
end
