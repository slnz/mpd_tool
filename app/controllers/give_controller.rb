class GiveController < ApplicationController
  before_action :validate_current_user, if: :signed_in?
  layout 'give'
  def current_user
    super.try(:becomes, User::Donor)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found'
  end

  protected

  def validate_current_user
    redirect_to edit_donor_path unless current_user.active?
  end
end
