ActiveAdmin.register Campus do
  config.per_page = 100
  scope :all, default: true
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
