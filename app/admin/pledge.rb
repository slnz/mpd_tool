ActiveAdmin.register Pledge do
  scope :all
  scope :pending
  scope :failure
  scope :success, default: true
  scope :complete
  config.per_page = 100
  decorate_with Decorator::PledgeDecorator
  actions :index, :destroy, :show
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
      Pledge
    end
  end

  batch_action :approve, confirm: 'This action is irreversible. Are You sure you want to do this?' do |ids, _inputs|
    scoped_collection.find(ids).each do |pledge|
      pledge.success! if pledge.failure? && pledge.valid?
    end
    redirect_to collection_path, notice: 'The failed pledges you selected have been pushed through as successes!'
  end
end
