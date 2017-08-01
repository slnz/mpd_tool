# frozen_string_literal: true

module Give
  class ProjectsController < GiveController
    decorates_assigned :project, :projects
    def index
      load_projects
    end

    def show
      load_project
      add_breadcrumb @project.title, project_path(id: @project.slug)
    end

    protected

    def load_projects
      @projects ||= project_scope
    end

    def load_project
      @project ||= project_scope.find(params[:project_id] || params[:id]) || raise(ActiveRecord::RecordNotFound)
    end

    def project_scope
      Project.opened.friendly
    end
  end
end
