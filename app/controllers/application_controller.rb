class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorize_admin!
    if current_user.nil? or !current_user.admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end

  def authenticate_user
    if !user_signed_in?
      raise ActionController::RountingError.new("Not Found")
    end
  end

  helper_method :handle_redirect

  def handle_redirect
    if request.xhr?
      head 200
    else
      redirect_to request.referer
    end
  end
end
