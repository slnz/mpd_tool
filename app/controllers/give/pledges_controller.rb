# frozen_string_literal: true

module Give
  class PledgesController < GiveController
    decorates_assigned :pledge, :pledges

    def index
      add_breadcrumb 'Donations', pledges_path
      load_pledges
    end

    protected

    def load_pledges
      @pledges ||= pledge_scope
    end

    def pledge_scope
      current_user.pledges.where(status: Pledge.statuses['success']).order('created_at desc')
    end
  end
end
