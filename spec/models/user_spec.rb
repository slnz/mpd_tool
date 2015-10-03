require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:first_name) }
  it { is_expected.to have_db_column(:last_name) }
  it { is_expected.to have_db_column(:image) }
  it { is_expected.to have_db_column(:provider) }
  it { is_expected.to have_db_column(:uid) }
  it { is_expected.to have_db_column(:designation_id) }
  it { is_expected.to have_db_column(:activation_code) }
  it { is_expected.to have_db_column(:admin) }
  it { is_expected.to have_db_column(:slug) }
  it { is_expected.to have_db_column(:description).of_type(:text) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to have_one(:designation) }
  it { is_expected.to have_many(:donations).through(:designation) }
  it 'allows user to associate designation' do
    @designation = create(:designation)
    user.activation_code = @designation.activation_code
    expect(user.designation).to_not be_nil
  end
  it 'validates the activation code' do
    @user = build(:user)
    @user.activation_code = 'fgnfrteert'
    expect(@user).to_not be_valid
  end
end
