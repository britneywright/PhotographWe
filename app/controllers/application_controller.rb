class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_user?, :require_logged_in_user, :require_authenticated_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user && session[:user_id] == user_id
  end

  def require_logged_in_user
    unless current_user
      flash[:error] = ["This area is only for logged in users."]
      redirect_to root_path
    end
  end

  def authenticated_user
    current_user == @album.user
  end

  def require_authenticated_user(user)
    unless current_user?(user)
      flash[:error] = ["You don't have access to this page"]
      redirect_to root_path
    end
  end

  def photo_ids_string
    @photographs.to_s.gsub(/\[|\]\s/,"")
  end  
end
