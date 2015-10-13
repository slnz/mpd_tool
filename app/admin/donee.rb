ActiveAdmin.register User::Donee, as: 'donee' do
  config.per_page = 100
  menu parent: :users
  scope :all
  scope(:active, default: true) { |scope| scope.where(donee_state: 1) }
  scope(:configured) { |scope| scope.where.not(activation_code: nil).setup }

  actions :index
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column(:email) do |donee|
      link_to "#{donee.email}",
              "mailto:#{donee.email}",
              target: '_blank'
    end
    column(:designation) do |donee|
      begin
        link_to donee.designation.try(:designation_code),
                admin_designation_path(donee.designation)
      rescue
        ''
      end
    end
    column(:facebook) do |donee|
      link_to 'Profile',
              "http://www.facebook.com/#{donee.uid}",
              target: '_blank'
    end
  end

  filter :email
  filter :first_name
  filter :last_name

  batch_action :email,
               form: { subject: :text, message: :textarea },
               confirm: 'Please enter the subject and the message below' do |ids, inputs|
    scoped_collection.find(ids).each do |donee|
      Mpd::DoneesMailer.update(donee, inputs[:subject], inputs[:message]).deliver
    end
    redirect_to collection_path, notice: 'The batch email has been sent to all the users you selected.'
  end

  controller do
    def scoped_collection
      User::Donee
    end
  end
end
