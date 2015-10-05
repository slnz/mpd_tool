class User
  class Donor < ActiveType::Record[User]
    validates :first_name, :last_name, :email, :phone, :address_line_1, :city, presence: true, if: :active?
    validates :email, email: true, if: :active?
    validates :terms, acceptance: { accept: true }, if: :active?
    enum donor_state: { setup: 0, active: 1}
  end
end
