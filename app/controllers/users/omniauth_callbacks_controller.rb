module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in @user, event: :authentication
      return unless is_navigational_format?
      set_flash_message(:notice, :success, kind: 'Facebook')
      redirect_to root_path if @user.designation_id
      redirect_to edit_user_path
    end
  end
end
