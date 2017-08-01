# frozen_string_literal: true

class Pledge
  class Response < ActiveType::Object
    attribute :pledge_id, :integer
    attribute :response, :hash

    belongs_to :pledge

    validates :pledge, presence: true
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
      return unless pxpay_response[:valid] == '1'
      pledge.update(payload: pxpay_response)
      pxpay_response[:success] == '1' ? pledge.success! : pledge.failure!
    end

    def pxpay_response
      self.response ||= Pxpay::Response.new(pledge.params).response.to_hash
    end
  end
end
