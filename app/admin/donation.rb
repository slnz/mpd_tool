# frozen_string_literal: true

ActiveAdmin.register Donation do
  config.per_page = 100
  scope :all, default: true
  menu parent: 'settings'
  permit_params :project_id, :contact_id, :designation_id, :display_date, :amount
  index do
    selectable_column
    id_column
    column(:designation) do |donation|
      begin
        des = Designation.find_by(designation_code: donation.designation_id)
        link_to donation.designation_id,
                admin_designation_path(des)
      rescue
        donation.designation_id
      end
    end
    column :project
    column :display_date
    column(:amount) { |d| number_to_currency d.amount }
    column :payment_type
    actions
  end

  action_item :fetch_donations do
    link_to 'Fetch Donations', fetch_admin_donations_path
  end

  collection_action :fetch do
    Donation::Fetch.from_dataserve
    redirect_to admin_donations_url, notice: 'Fetched Donations'
  end

  show do
    attributes_table do
      row :id
      row :global_id
      row(:amount) { |d| number_to_currency d.amount }
      row :display_date
      row :project
      row :payment_type
      row :designation
    end
  end

  form do |f|
    f.inputs do
      f.input :project
      f.input :contact, collection: Contact.select(:id, :name).distinct.order(:name)
      f.input :designation_id,
              as: :select,
              collection:
                Designation.order(:last_name).all.map { |d| ["#{d.last_name}, #{d.first_name}", d.designation_code] }
      f.input :display_date
      f.input :amount
    end
    f.actions
  end
end
