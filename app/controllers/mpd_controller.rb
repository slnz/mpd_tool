class MpdController < ApplicationController
  before_action :validate_current_user, if: :signed_in?
  layout 'mpd'
  def current_user
    super.try(:becomes, User::Donee)
  end

  def validate_current_user
    redirect_to edit_donee_path unless current_user.active?
  end
end
