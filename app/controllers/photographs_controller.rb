class PhotographsController < ApplicationController
  before_action :set_album
  before_action :set_photograph, only: [:show, :edit, :update, :delete]

  def update
    @photograph.update(photograph_params)
    redirect_to @album
  end

  def destroy
    @album = Album.find_by(id: params[:album_id])    
    @photograph = Photograph.find_by(id: params[:id])
    @photograph.delete
    redirect_to @album
  end

  def add
    @photographs = []
    if params[:photographs]
      params[:photographs].each do |source|
        photograph = Photograph.new(source: source, album: @album)
        if current_user
          photograph.uploader = current_user
        end
        if photograph.save
          @photographs << photograph.id
        end
      end
    end
    redirect_to personalize_album_photographs_path(@album,photo_ids_string)
  end

  def personalize
    @photographs = []
    photo_ids_array.each do |photo|
      @photographs << Photograph.find_by(id: photo.to_i)
    end
  end

  def update_submission
    Photograph.update(params[:photographs].keys, params[:photographs].values)
    redirect_to @album
  end

  private

  def photograph_params
    params.require(:photograph).permit(:source, :caption)
  end

  def set_album
    @album = Album.find_by(slug: params[:album_id])
  end

  def set_photograph
    @photograph = Photograph.find_by(id: params[:id])
  end

  def photo_ids_array
    params[:list].split(",")
  end
end
