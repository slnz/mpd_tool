class GiveController < ApplicationController
  before_action :validate_current_user, if: :signed_in?
  layout 'give'
  def current_user
    super.try(:becomes, User::Donor)
  end

  def validate_current_user
    redirect_to edit_donor_path unless current_user.active?
  end
end
