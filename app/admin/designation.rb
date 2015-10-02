ActiveAdmin.register Designation do
  permit_params :email, :first_name, :last_name, :designation_code, :campus_id

  active_admin_import(
    validate: true,
    template_object: ActiveAdminImport::Model.new(
      hint: '<strong>Headers</strong><br>'\
            'email, first_name, last_name, designation_code',
      csv_headers: %w(email first_name last_name designation_code)
    ),
    back: { action: :index },
    after_import: proc do
      Designation.where(email_sent: false).each(&:send_activation_code)
    end
  )

  index do
    selectable_column
    id_column
    column :designation_code
    column :name
    column(:amount_raised) { |d| number_to_currency d.amount_raised }
    column :campus
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :designation_code
  filter :campus

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :designation_code
      f.input :campus
    end
    f.actions
  end
end
