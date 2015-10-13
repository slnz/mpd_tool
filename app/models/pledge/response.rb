class Pledge
  class Response < ActiveType::Object
    attribute :pledge_id, :integer
    attribute :params, :hash

    belongs_to :pledge

    validates :pledge, :params, presence: true
    after_validation :update_pledge

    protected

    def update_pledge
      send(pledge.giving_method.parameterize.underscore)
      pledge.create_subscription if pledge.success?
    end

    def credit_card
      pxpay
    end

    def internet_banking
      pxpay
    end

    def pxpay
      response = Pxpay::Response.new(params).response.to_hash
      pledge.update(payload: response)
      return pledge.success! if response[:success] == '1'
      pledge.failure!
    end
  end
end
