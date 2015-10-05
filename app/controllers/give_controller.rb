class GiveController < ApplicationController
  layout 'give'
  def current_user
    super.try(:becomes, User::Donor)
  end
end
