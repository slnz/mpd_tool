# frozen_string_literal: true

class GiveController < ApplicationController
  before_action :validate_current_user, if: :signed_in?
  layout 'give'
  def current_user
    super.try(:becomes, User::Donor)
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render 'not_found'
  end

  protected

  def validate_current_user
    return if current_user.active?
    session[:redirect_to] = request.fullpath
    redirect_to edit_donor_path
  end
end
