# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def new
      store_location_for(:user, params[:redirect_to]) if params[:redirect_to].present?
      super
    end

    protected

    def after_sign_up_path_for(resource)
      stored_location_for(resource) || super
    end
  end
end
