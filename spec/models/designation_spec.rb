require 'rails_helper'

RSpec.describe Designation, type: :model do
  subject { create(:designation) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:designation_code) }
  it { is_expected.to validate_presence_of(:activation_code) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:donations) }
  it { is_expected.to have_db_index(:activation_code).unique(true) }
  it 'sends an activation code email' do
    expect { create(:designation) }.to(
      change { ActionMailer::Base.deliveries.count }.by(1)
    )
  end
end
