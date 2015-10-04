module Give
  class DoneesController < GiveController
    decorates_assigned :donee, :designation, :project
    def show
      load_donee
      load_designation
      load_project
      render 'show_no_project' unless @project
    end

    protected

    def load_donee
      @donee ||= donee_scope.find(params[:donee_id] || params[:id]) || fail(ActiveRecord::RecordNotFound)
    end

    def load_designation
      @designation ||= load_donee.try(:designation)
    end

    def load_project
      @project ||= load_designation.try(:project)
    end

    def donee_scope
      User::Donee.friendly
    end
  end
end
