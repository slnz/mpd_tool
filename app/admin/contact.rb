# frozen_string_literal: true

ActiveAdmin.register Contact do
  config.per_page = 100
  scope :all, default: true
  menu parent: 'settings'
  permit_params :name, :code

  index do
    selectable_column
    id_column
    column :name
    column :code
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :code
    end
    f.actions
  end

  filter :name
end
