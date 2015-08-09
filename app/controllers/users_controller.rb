class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def show
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
