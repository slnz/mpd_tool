module Give
  module Donees
    class PledgesController < DoneesController
      decorates_assigned :pledges, :pledge
      before_action :authenticate_user!, except: [:about, :index, :new, :success, :failure]
      before_action :check_project, except: [:index]
      add_breadcrumb 'Giving', proc { |c| c.donee_pledges_path(donee_id: c.donee.slug) }

      def index
        load_pledges if user_signed_in?
      end

      def show
        load_pledge
        add_breadcrumb 'Donation', donee_pledge_path(donee_id: donee.slug, id: @pledge.id)
      end

      def new
        build_pledge if user_signed_in?
        add_breadcrumb 'New', new_donee_pledge_path(donee_id: donee.slug)
      end

      def create
        build_pledge
        return render action: :new unless save_pledge
        redirect_to create_request.reference_address
      end

      def success
        load_pledge
        create_response
        return redirect_to action: :show if current_user
        render text: 'success'
      end

      def failure
        load_pledge
        create_response
        return redirect_to action: :show if current_user
        render text: 'failure'
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
        @pledge.project = @project
      end

      def save_pledge
        @pledge.save
      end

      def pledge_scope
        current_user ? current_user.pledges.where(designation: @designation) : Pledge
      end

      def create_request
        @request ||=
          @pledge.create_request(
            success_url: success_donee_pledge_url(donee_id: @donee.slug, id: @pledge.id),
            failure_url: failure_donee_pledge_url(donee_id: @donee.slug, id: @pledge.id)
          )
      end

      def create_response
        @response ||= @pledge.create_response(params)
      end

      def pledge_params
        pledge_params = params[:pledge]
        return {} unless pledge_params
        pledge_params.permit(:newsletter, :amount, :giving_method)
      end
    end
  end
end
