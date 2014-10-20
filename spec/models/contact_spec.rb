require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to have_db_column(:designation_code) }
  it { is_expected.to have_db_column(:code) }
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:address) }
  it { is_expected.to have_db_column(:phone) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:donations) }
  it do
    is_expected.to validate_uniqueness_of(:code).scoped_to(:designation_code)
  end
end
