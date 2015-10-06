module Give
  class DoneesController < GiveController
    decorates_assigned :donee, :designation, :project
    before_action :load_donee, :load_designation, :load_project
    before_action :check_project, except: [:show]
    add_breadcrumb proc { |c| c.donee.name }, proc { |c| c.donee_path(id: c.donee.slug) }

    def show
    end

    def about
      add_breadcrumb 'About', about_donee_path(donee)
    end

    protected

    def check_project
      return redirect_to donee_path(donee) unless @project
    end

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
