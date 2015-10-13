class Pledge
  class Response < ActiveType::Object
    attribute :pledge_id, :integer

    belongs_to :pledge

    validates :pledge, :params, presence: true
    after_validation :update_pledge

    protected

    def update_pledge
      send(pledge.giving_method.parameterize.underscore)
      pledge.create_subscription if pledge.success?
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

    def pxpay
      response = Pxpay::Response.new(pledge.params).response.to_hash
      pledge.update(payload: response)
      return pledge.success! if response[:success] == '1'
      pledge.failure!
    end
  end
end
