# frozen_string_literal: true

class MpdController < ApplicationController
  decorates_assigned :donee, :designation, :project
  before_action :load_donee, :load_designation, :load_project, if: :signed_in?
  before_action :validate_current_user, if: :signed_in?
  layout 'mpd'

  def current_user
    super.try(:becomes, User::Donee)
  end

  protected

  def validate_current_user
    redirect_to edit_donee_path unless current_user.active?
  end

  def load_donee
    @donee ||= current_user
  end

  def load_designation
    @designation ||= load_donee.try(:designation)
    @donee.update_column(:donee_state, User::Donee.donee_states['setup']) unless @designation
    @designation
  end

  def load_project
    @project ||= load_designation.try(:project)
  end
end
