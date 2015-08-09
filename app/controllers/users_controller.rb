class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def new
    @user = User.new
  end

  def show
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user, notice: "User created successfully"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :username, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
