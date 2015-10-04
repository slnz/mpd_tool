class GiveController < ApplicationController
  def current_user
    super.try(:becomes, User::Donor)
  end
end
