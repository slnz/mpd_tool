# frozen_string_literal: true

module Give
  class DonorsController < GiveController
    decorates_assigned :donor
    skip_before_action :validate_current_user
    def edit
      add_breadcrumb 'Profile', edit_donor_path
      load_donor
    end

    def update
      load_donor
      build_donor
      return render action: :edit unless save_donor
      flash[:success] = 'Your profile has been updated'
      redirect_to session[:redirect_to] || edit_donor_path
      session.delete(:redirect_to) if session[:redirect_to]
    end

    protected

    def load_donor
      @donor ||= donor_scope
    end

    def build_donor
      @donor.attributes = donor_params
      @donor.donor_state = User::Donor.donor_states[:active]
    end

    def save_donor
      @donor.save
    end

    def donor_scope
      current_user
    end

    def donor_params
      donor_params = params[:user]
      return {} unless donor_params
      donor_params.permit(
        :first_name, :last_name, :email, :phone, :address_line_1, :address_line_2, :city, :postcode, :terms
      )
    end
  end
end
