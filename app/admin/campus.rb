ActiveAdmin.register Campus do
  menu parent: 'settings'
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name
end
