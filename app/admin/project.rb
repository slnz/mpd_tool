ActiveAdmin.register Project do
  permit_params :title, :code, :goal, :description, :date
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
end
