ActiveAdmin.register Contact do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :code
    actions
  end

  filter :name
end
