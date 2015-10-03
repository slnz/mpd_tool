ActiveAdmin.register Project do
  permit_params :title, :code, :goal, :description

  index do
    selectable_column
    id_column
    column :title
    column :code
    column :goal
    actions
  end

  filter :title
  filter :code
end
