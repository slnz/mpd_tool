module Users
  class SessionsController < Devise::SessionsController
    def new
      store_location_for(:user, params[:redirect_to]) if params[:redirect_to].present?
      super
    end

    protected

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || super
    end
  end
end
