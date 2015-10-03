module Give
  class UsersController < ApplicationController
    def show
      load_user
      render 'show_no_project' unless @user.designation.try(:project)
    end

    protected

    def load_user
      @user ||= user_scope.find_by(permalink: params[:id]) || fail(ActiveRecord::RecordNotFound)
    end

    def user_scope
      User
    end
  end
end