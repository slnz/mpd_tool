module Give
  module Donees
    class PledgesController < DoneesController
      decorates_assigned :pledges, :pledge
      before_action :load_donee, :load_designation, :load_project
      before_action :authenticate_user!, except: [:about, :index, :new]
      add_breadcrumb 'Giving', proc { |c| c.donee_pledges_path(donee_id: c.donee.slug) }

      def index
        load_pledges if user_signed_in?
      end

      def show
        load_pledge
        add_breadcrumb 'Pledge', donee_pledge_path(donee_id: donee.slug, id: @pledge.id)
      end

      def new
        build_pledge if user_signed_in?
        add_breadcrumb 'New', new_donee_pledge_path(donee_id: donee.slug)
      end

      def about
        add_breadcrumb 'About', about_donee_pledges_path(donee_id: donee.slug)
      end

      def create
        build_pledge
        return render action: :new unless save_pledge
        redirect_to create_request.reference_address
      end

      def success
        load_pledge
        create_response
        redirect_to action: :show
      end

      protected

      def load_pledges
        @pledges ||= pledge_scope.success
      end

      def load_pledge
        @pledge ||= pledge_scope.find(params[:id])
      end

      def build_pledge
        @pledge ||= pledge_scope.build
        @pledge.attributes = pledge_params
        @pledge.designation = @designation
      end

      def save_pledge
        @pledge.save
      end

      def pledge_scope
        current_user.pledges
      end

      def create_request
        @request ||=
          @pledge.create_request(
            success_url: success_donee_pledge_url(donee_id: @donee.slug, id: @pledge.id),
            failure_url: failure_donee_pledge_url(donee_id: @donee.slug, id: @pledge.id)
          )
      end

      def create_response
        @response ||= @pledge.create_response(params: params)
      end

      def pledge_params
        pledge_params = params[:pledge]
        return {} unless pledge_params
        pledge_params.permit(:prayer_only, :newsletter, :amount, :giving_method)
      end
    end
  end
end
