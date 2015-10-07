class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_breadcrumb 'Home', :root_path
  helper_method :me?
  def authenticate_admin_user!
    fail SecurityError unless current_user.try(:admin?)
  rescue SecurityError
    flash[:error] = 'You are not an Admin'
    redirect_to root_path
  end

  def me?(donee)
    return false unless user_signed_in?
    donee.try(:id) == current_user.try(:id)
  end
end
