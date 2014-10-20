require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { is_expected.to validate_presence_of(:global_id) }
  it { is_expected.to validate_uniqueness_of(:global_id) }
  it { is_expected.to validate_presence_of(:contact_id) }
  it { is_expected.to validate_presence_of(:designation_id) }
  it { is_expected.to validate_presence_of(:display_date) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:project) }
  it { is_expected.to have_db_column(:payment_method) }
  it { is_expected.to belong_to(:project) }
end
