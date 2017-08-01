# frozen_string_literal: true

module Give
  class DoneesController < GiveController
    decorates_assigned :donee, :designation, :project
    before_action :load_donee, :load_designation, :load_project, except: [:find]
    before_action :check_project, except: %i[show find]
    add_breadcrumb (proc { |c| c.donee.name }), (proc { |c| c.donee_path(id: c.donee.slug) })

    def show; end

    def about
      add_breadcrumb 'About', about_donee_path(donee)
    end

    def find
      load_donees
      filter_donees
      render json: @donees.to_json(only: %i[name slug], methods: %i[large_image])
    end

    protected

    def check_project
      return redirect_to donee_path(donee) unless @project
    end

    def load_donees
      @donees ||= donee_scope.all
    end

    def filter_donees
      @donees = if params[:search].blank?
                  @donees.none
                else
                  @donees.search_by_full_name(params[:search])
                end
    end

    def load_donee
      @donee ||= donee_scope.find(params[:donee_id] || params[:id]) || raise(ActiveRecord::RecordNotFound)
    end

    def load_designation
      @designation ||= load_donee.try(:designation)
    end

    def load_project
      @project ||= load_designation.try(:project)
    end

    def donee_scope
      User::Donee.active.friendly
    end
  end
end
