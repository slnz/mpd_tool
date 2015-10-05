module Give
  module Donees
    class PledgesController < DoneesController
      decorates_assigned :pledge
      before_action :load_donee, :load_designation, :load_project
      before_action :authenticate_user!, only: [:create]
      add_breadcrumb 'Help', proc { |c| c.new_donee_pledges_path(donee_id: c.donee.slug) }
      def new
        build_pledge
        add_breadcrumb 'New', new_donee_pledges_path(donee_id: donee.slug)
      end

      def about
        add_breadcrumb 'About', about_donee_pledges_path(donee_id: donee.slug)
      end

      def thanks
        add_breadcrumb 'Thanks', thanks_donee_pledges_path(donee_id: donee.slug)
      end

      def create
        build_pledge
        return render action: :new unless save_pledge
        flash[:success] = 'Your pledge has been received'
        return redirect_to action: :thanks if @pledge.prayer_only?
      end

      protected

      def build_pledge
        @pledge ||= pledge_scope.build
        @pledge.attributes = pledge_params
        @pledge.donor = current_user
      end

      def save_pledge
        @pledge.save
      end

      def pledge_scope
        @designation.pledges
      end

      def pledge_params
        pledge_params = params[:pledge]
        return {} unless pledge_params
        pledge_params.permit(:prayer_only, :newsletter, :amount)
      end
    end
  end
end
