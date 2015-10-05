module Mpd
  class DoneesController < MpdController
    decorates_assigned :donor
    def edit
      load_donor
      render 'activate' unless @donor.designation
    end

    def update
      load_donor
      build_donor
      if save_donor
        flash[:success] = 'Your Profile has updated'
      else
        flash[:error] = @donor.errors.full_messages.join('. ')
      end
      redirect_to action: :edit
    end

    protected

    def load_donor
      @donor ||= donor_scope
    end

    def build_donor
      @donor.attributes = donor_params
    end

    def save_donor
      @donor.save
    end

    def donor_scope
      current_user
    end

    def donor_params
      donor_params = params[:donor]
      return {} unless donor_params
      donor_params.permit(:activation_code, :description)
    end
  end
end
