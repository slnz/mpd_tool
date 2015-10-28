ActiveAdmin.register Pledge do
  scope :all
  scope :pending
  scope :failure
  scope :success, default: true
  scope :complete
  config.per_page = 50
  decorate_with Decorator::PledgeDecorator
  actions :index, :destroy, :show
  index do
    selectable_column
    id_column
    column(:desingation_id) { |p| link_to p.code, admin_designation_path(p.designation) }
    column(:donation_id) { |p| link_to p.donation_id, admin_donation_path(p.donation) if p.donation }
    column :donee
    column :donor
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

  batch_action :mark_as_success,
               confirm: 'This action is irreversible. This only applies to pledges marked as failures. '\
                        'Are You sure you want to do this?' do |ids, _inputs|
    scoped_collection.find(ids).each do |pledge|
      pledge.success! if pledge.failure? && pledge.valid?
    end
    redirect_to collection_path, notice: 'The failed pledges you selected have been pushed through as successful!'
  end

  batch_action :mark_as_complete,
               confirm: 'This action is irreversible. This only applies to pledges marked as successful. '\
                        'Are You sure you want to do this?' do |ids, _inputs|
    scoped_collection.find(ids).each do |pledge|
      return unless pledge.success? && pledge.valid?
      pledge.complete!
      pledge.donation.try(:destroy!)
    end
    redirect_to collection_path, notice: 'The successful pledges you selected have been pushed through as completed!'
  end

  csv force_quotes: true do
    column(:pledge_id) { |p| p.id }
    column(:tendered_amount) { |p| number_with_precision p.amount, precision: 2 }
    column(:payment_type_code) { |p| p.donor_wise_payment_type }
    column(:donation_memo) { |p| p.donation_id }
    column(:designation_id) { |p| p.code }
    column(:donor_id) { |p| p.contact.try(:code) }
    column(:donor_name) { |p| p.donor_name }
    column(:donor_address) { |p| p.donor.try(:short_address) }
  end
end
