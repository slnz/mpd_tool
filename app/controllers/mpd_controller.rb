class MpdController < ApplicationController
  layout 'mpd'
  def current_user
    super.try(:becomes, User::Donee)
  end
end
