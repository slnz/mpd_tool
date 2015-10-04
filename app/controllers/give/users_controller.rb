module Give
  class UsersController < GiveController
    def show
      load_user
      load_designation
      load_project
      render 'show_no_project' unless @project
    end

    protected

    def load_user
      @user ||= user_scope.find(params[:user_id] || params[:id]) || fail(ActiveRecord::RecordNotFound)
    end

    def load_designation
      @designation ||= load_user.try(:designation)
    end

    def load_project
      @project ||= load_designation.try(:project)
    end

    def user_scope
      User::Donee.friendly
    end
  end
end
