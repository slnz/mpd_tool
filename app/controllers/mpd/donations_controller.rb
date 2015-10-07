module Mpd
  class DonationsController < MpdController
    has_scope :project
    add_breadcrumb 'Donations', proc { |c| c.donations_path }

    def index
      load_donations
    end

    def show
      load_donation
    end

    protected

    def load_donations
      @q ||= apply_scopes(donation_scope).search(params[:q])
      @donations ||= @q.result.includes(:contact).page(params[:page])
    end

    def load_donation
      @donation ||= donation_scope.find(params[:id])
    end

    def donation_scope
      current_user.donations
    end
  end
end
