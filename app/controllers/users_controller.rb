class UsersController < ApplicationController
  def edit
    load_user
    redirect_to root_path if @user.designation
  end

  def update
    load_user
    return redirect_to root_path if @user.designation
    build_user
    save_user || render(action: :edit)
    return if performed?
    flash[:success] = 'Your Account has been activated'
    redirect_to root_path
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
    user_params.permit(:activation_code)
  end
end
