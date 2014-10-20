ActiveAdmin.register Designation do
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
    column :email
    column :first_name
    column :last_name
    column :designation_code
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :designation_code

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :designation_code
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit(
        :utf8, :_method, :authenticity_token, :commit, :id,
        designation: [:email, :first_name, :last_name, :designation_code]
      )
    end
  end
end
