ActiveAdmin.register Pledge do
  scope :all, default: true
  config.per_page = 100
  decorate_with Decorator::PledgeDecorator
  actions :index, :destroy
  index do
    selectable_column
    id_column
    column(:desingation_id) { |p| link_to p.code, admin_designation_path(p.designation) }
    column(:donation_id) { |p| link_to p.donation_id, admin_donation_path(p.donation) if p.donation }
    column :donee_name
    column :donor_name
    column(:amount) { |p| number_to_currency p.amount }
    column :giving_method
    column :display_date
    actions
  end

  controller do
    def scoped_collection
      Pledge.success
    end
  end
end
