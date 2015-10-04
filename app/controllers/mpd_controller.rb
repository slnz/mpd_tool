class MpdController < ApplicationController
  def current_user
    super.try(:becomes, User::Donee)
  end
end
