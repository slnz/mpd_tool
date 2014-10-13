module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in_and_redirect @user, event: :authentication
      return unless is_navigational_format?
      set_flash_message(:notice, :success, kind: 'Facebook')
    end
  end
end
