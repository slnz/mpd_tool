class Designation < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :designation_code, presence: true
  validates :email, presence: true, uniqueness: true
  validates :activation_code, presence: true
  before_validation :generate_activation_code, on: :create
  after_save :send_activation_code, on: :create
  belongs_to :user
  has_many :donations, primary_key: :designation_code

  def send_activation_code
    generate_activation_code unless activation_code
    DesignationMailer.send_activation_code(self).deliver
    self.email_sent = true
    save unless persisted?
  end

  protected

  def generate_activation_code
    loop do
      self.activation_code = SecureRandom.hex.upcase[0, 5]
      break unless Designation.find_by(activation_code: activation_code)
    end
  end
end
