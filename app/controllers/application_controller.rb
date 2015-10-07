class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_breadcrumb 'Home', :root_path
  helper_method :me?, :current_donee, :current_donor
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

  def current_donor
    current_user.try(:becomes, User::Donor)
  end

  def current_donee
    current_user.try(:becomes, User::Donee)
  end
end
