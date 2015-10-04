module Mpd
  class UsersController < MpdController
    def edit
      load_user
      render 'activate' unless @user.designation
    end

    def update
      load_user
      build_user
      if save_user
        flash[:success] = 'Your Profile has updated'
      else
        flash[:error] = @user.errors.full_messages.join('. ')
      end
      redirect_to action: :edit
    end

    protected

    def load_user
      @user ||= user_scope
    end

    def build_user
      @user.attributes = user_params
    end

    def save_user
      @user.save
    end

    def user_scope
      current_user
    end

    def user_params
      user_params = params[:user]
      return {} unless user_params
      user_params.permit(:activation_code, :description)
    end
  end
end
