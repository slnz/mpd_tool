class Pledge
  class Request < ActiveType::Object
    attribute :designation_id, :integer
    attribute :donee_id, :integer
    attribute :donor_id, :integer
    attribute :pledge_id, :integer
    attribute :reference_address, :string
    attribute :success_url, :string
    attribute :failure_url, :string

    belongs_to :designation
    belongs_to :donee, class_name: 'User::Donee'
    belongs_to :donor, class_name: 'User::Donor'
    belongs_to :pledge

    validates :designation, :donee, :donor, :pledge, presence: true
    before_validation :generate_associations
    after_validation :generate_reference_address

    protected

    def generate_associations
      self.designation ||= pledge.designation
      self.donee ||= designation.donee
      self.donor ||= pledge.donor
    end

    def generate_reference_address
      self.reference_address ||= send(pledge.giving_method.parameterize.underscore)
    end

    def credit_card
      Pxpay::Base.pxpay_user_id = ENV.fetch('PXPAY_CC_USER_ID')
      Pxpay::Base.pxpay_key = ENV.fetch('PXPAY_CC_KEY')
      pxpay
    end

    def internet_banking
      Pxpay::Base.pxpay_user_id = ENV.fetch('PXPAY_IB_USER_ID')
      Pxpay::Base.pxpay_key = ENV.fetch('PXPAY_IB_KEY')
      pxpay
    end

    def pxpay_options
      {
        email: donor.email,
        txn_data1: pledge.id,
        txn_data2: donor.reference_name,
        txn_data3: donee.reference_name,
        url_success: success_url,
        url_failure: failure_url
      }
    end

    def pxpay
      request = Pxpay::Request.new("#{pledge.id}_#{designation.designation_code}", pledge.amount, pxpay_options)
      request.url
    end
  end
end
