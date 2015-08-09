class SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])
    if user.try(:authenticate, params[:username])
      session[:user_id] = user.id
      redirect_to user, notice "Welcome back!"
    else
      flash[:errors] = ["Invalid login"]
      redirect_to root_path
    end
  end

  def logout
    session.clear
    redirect_to_root_path, notice: "Logged out successfully"
  end
end
