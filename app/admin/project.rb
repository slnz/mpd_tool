ActiveAdmin.register Project do
  menu parent: 'settings'
  permit_params :title, :code, :goal, :description, :date, :slug
  decorate_with Decorator::ProjectDecorator

  index do
    selectable_column
    id_column
    column :title
    column :code
    column :goal
    column :date
    actions
  end

  filter :title
  filter :code

  controller do
    def find_resource
      Project.friendly.find(params[:id])
    end
  end
end
