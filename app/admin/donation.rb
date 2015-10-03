ActiveAdmin.register Donation do
  actions :index
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
    column :amount
    actions
  end

  action_item :fetch_donations do
    link_to 'Fetch Donations', fetch_admin_donations_path
  end

  collection_action :fetch do
    Donation::Fetch.from_dataserve 1.month
    redirect_to admin_donations_url, notice: 'Fetched Donations'
  end
end
