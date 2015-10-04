module Give
  module Donees
    class PledgesController < DoneesController
      decorates_assigned :pledge
      before_action :load_donee, :load_designation, :load_project

      def new
        build_pledge
      end

      def about
      end

      def create
        build_pledge
        flash[:success] = 'Your Profile has updated' if save_pledge
        render action: :new
      end

      protected

      def build_pledge
        @pledge ||= pledge_scope.build
        @pledge.attributes = pledge_params
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
        pledge_params.permit(
          :first_name, :last_name, :amount, :email, :phone,
          :address_line_1, :address_line_2, :city, :postcode,
          :terms, :newsletter)
      end
    end
  end
end
