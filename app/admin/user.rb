# frozen_string_literal: true

ActiveAdmin.register User do
  scope :all, default: true
  config.per_page = 100
  scope :all, default: true
  decorate_with Decorator::UserDecorator
  scope(:donee) { |scope| scope.where(donee_state: 1) }
  scope(:donor) { |scope| scope.where(donor_state: 1) }
  actions :index, :show
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column(:email) do |user|
      link_to user.email.to_s,
              "mailto:#{user.email}",
              target: '_blank'
    end
    column(:designation) do |user|
      begin
        link_to user.becomes(User::Donee).designation.try(:designation_code),
                admin_designation_path(user.becomes(User::Donee).designation)
      rescue
        ''
      end
    end
    column(:facebook) do |user|
      link_to 'Profile',
              "http://www.facebook.com/#{user.uid}",
              target: '_blank'
    end
    column(:role) do |user|
      status_tag('admin', :ok) if user.admin?
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :phone
      row(:address) { |u| simple_format u.address }
    end
  end

  filter :email
  filter :first_name
  filter :last_name

  batch_action :toggle_admin do |selection|
    User.find(selection).each do |user|
      user.toggle(:admin).save
    end
    flash[:notice] = 'Toggled Admin Status'
    redirect_to admin_users_path
  end

  controller do
    def find_resource
      User.friendly.find(params[:id])
    end
  end
end
