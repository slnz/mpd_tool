module Give
  class PledgesController < GiveController
    decorates_assigned :pledge, :pledges
    def index
      load_pledges
    end

    protected

    def load_pledges
      @pledges ||= pledge_scope
    end

    def pledge_scope
      current_user.pledges.where(status: [Pledge.statuses['success'],
                                          Pledge.statuses['complete']]).order('created_at desc')
    end
  end
end
