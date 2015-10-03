ActiveAdmin.register Designation do
  permit_params :email, :first_name, :last_name, :designation_code, :campus_id

  active_admin_import(
    validate: true,
    headers_rewrites: { campus: :campus_id },
    template_object: ActiveAdminImport::Model.new(
      hint: '<strong>Headers</strong><br>'\
            'email, first_name, last_name, designation_code, campus',
      csv_headers: %w(email first_name last_name designation_code campus)
    ),
    back: { action: :index },
    before_batch_import: proc do |importer|
      campus_names = importer.values_at(:campus_id)
      campuses = Campus.where(name: campus_names).pluck(:name, :id)
      options = Hash[*campuses.flatten]
      importer.batch_replace(:campus_id, options)
    end,
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

  csv do
    column :email
    column :first_name
    column :last_name
    column :designation_code
    column(:campus) { |d| d.campus.try(:name) }
    column(:amount_raised) { |d| number_to_currency d.amount_raised }
  end
end
