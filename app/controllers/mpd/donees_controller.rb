module Mpd
  class DoneesController < MpdController
    decorates_assigned :donee
    skip_before_action :validate_current_user
    def edit
      add_breadcrumb 'Profile', edit_donor_path
      load_donee
    end

    def update
      load_donee
      build_donee
      return render action: :edit unless save_donee
      flash[:success] = 'Your profile has been updated'
      redirect_to action: :edit
    end

    protected

    def load_donee
      @donee ||= donee_scope
    end

    def build_donee
      @donee.attributes = donee_params
      @donee.donee_state = User::Donee.donee_states[:active]
    end

    def save_donee
      @donee.save
    end

    def donee_scope
      current_user
    end

    def donee_params
      donee_params = params[:user]
      return {} unless donee_params
      donee_params.permit(:activation_code, :description, :first_name, :last_name,
                          :email, :phone, :address_line_1, :address_line_2, :city, :postcode, :terms)
    end
  end
end
