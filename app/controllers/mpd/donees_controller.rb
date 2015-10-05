module Mpd
  class DoneesController < MpdController
    decorates_assigned :donee
    def edit
      load_donee
      render 'activate' unless @donee.designation
    end

    def update
      load_donee
      build_donee
      if save_donee
        flash[:success] = 'Your Profile has updated'
      else
        flash[:error] = @donee.errors.full_messages.join('. ')
      end
      redirect_to action: :edit
    end

    protected

    def load_donee
      @donee ||= donee_scope
    end

    def build_donee
      @donee.attributes = donee_params
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
      donee_params.permit(:activation_code, :description)
    end
  end
end
