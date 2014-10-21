ActiveAdmin.register User do
  actions :index, :show
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column(:email) do |user|
      link_to "#{user.email}",
              "mailto:#{user.email}",
              target: '_blank'
    end
    column(:designation) do |user|
      begin
        link_to user.designation.try(:designation_code),
                admin_designation_path(user.designation)
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
end
