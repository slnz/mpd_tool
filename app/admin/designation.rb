ActiveAdmin.register Designation do
  config.per_page = 100
  scope :all, default: true
  scope(:active) { |scope| scope.where.not(donee: nil) }
  scope(:inactive) { |scope| scope.where(donee: nil) }
  permit_params :email, :first_name, :last_name, :designation_code, :campus_id, :project_id
  decorate_with Decorator::DesignationDecorator
  active_admin_import(
    validate: true,
    headers_rewrites: { campus: :campus_id, project: :project_id },
    template_object: ActiveAdminImport::Model.new(
      hint: '<strong>Headers</strong><br>'\
            'email, first_name, last_name, designation_code, campus, project',
      csv_headers: %w(email first_name last_name designation_code campus project)
    ),
    back: { action: :index },
    before_batch_import: proc do |importer|
      campus_names = importer.values_at(:campus_id)
      campuses = Campus.where(name: campus_names).pluck(:name, :id)
      campus_options = Hash[*campuses.flatten]
      importer.batch_replace(:campus_id, campus_options)

      project_names = importer.values_at(:project_id)
      projects = Project.where(title: project_names).pluck(:title, :id)
      project_options = Hash[*projects.flatten]
      importer.batch_replace(:project_id, project_options)
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
    column :project
    actions
  end

  show do
    attributes_table do
      row :designation_code
      row :name
      row(:amount_raised) { |d| number_to_currency d.amount_raised }
      row :campus
      row :project
      row :email_sent
    end
  end
  filter :email
  filter :first_name
  filter :last_name
  filter :designation_code
  filter :campus
  filter :project

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :designation_code
      f.input :campus
      f.input :project
    end
    f.actions
  end

  csv do
    column :email
    column :first_name
    column :last_name
    column :designation_code
    column(:campus) { |d| d.campus.try(:name) }
    column(:project) { |d| d.campus.try(:title) }
    column(:amount_raised) { |d| number_to_currency d.amount_raised }
  end

  batch_action :email, form: { subject: :text, message: :textarea }, confirm: 'Please enter the subject and the message below' do |ids, inputs|
    scoped_collection.find(ids).each do |donee|
      Mpd::DoneesMailer.update(donee, inputs[:subject], inputs[:message]).deliver
    end
    redirect_to collection_path, notice: 'The batch email has been sent to all the users you selected.'
  end
end
