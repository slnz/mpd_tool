# frozen_string_literal: true

module Mpd
  class DonationsController < MpdController
    has_scope :project
    add_breadcrumb 'Donations', proc { |c| c.donations_path }
    decorates_assigned :donations

    def index
      load_donations
    end

    protected

    def load_donations
      @q ||= apply_scopes(donation_scope).search(params[:q])
      @donations ||= @q.result.includes(:contact).page(params[:page])
    end

    def donation_scope
      current_user.donations
    end
  end
end
