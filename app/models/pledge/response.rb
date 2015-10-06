class Pledge
  class Response < ActiveType::Object
    attribute :pledge_id, :integer
    attribute :params, :hash

    belongs_to :pledge

    validates :pledge, :params, presence: true
    after_validation :update_pledge

    protected

    def update_pledge
      response = Pxpay::Response.new(params).response.to_hash
      return pledge.success! if response[:success] == '1'
      pledge.failure!
    end
  end
end
