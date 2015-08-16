class PhotographsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:album_id])
    @photograph = Photograph.find_by(id: params[:id])
  end

  private

  def photograph_params
    params.require(:photograph).permit(:source, :caption)
  end
end
