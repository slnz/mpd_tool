require 'rails_helper'

RSpec.describe Pledge, type: :model do
  it { is_expected.to have_db_column(:first_name).of_type(:string) }
  it { is_expected.to have_db_column(:last_name).of_type(:string) }
  it { is_expected.to have_db_column(:amount).of_type(:decimal) }
  it { is_expected.to have_db_column(:anonymous).of_type(:boolean) }
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:phone).of_type(:string) }
  it { is_expected.to have_db_column(:organization).of_type(:string) }
  it { is_expected.to have_db_column(:address_line_1).of_type(:string) }
  it { is_expected.to have_db_column(:address_line_2).of_type(:string) }
  it { is_expected.to have_db_column(:city).of_type(:string) }
  it { is_expected.to have_db_column(:postcode).of_type(:string) }
  it { is_expected.to have_db_column(:method).of_type(:integer) }
  it { is_expected.to have_db_column(:terms).of_type(:boolean) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:address_line_1) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_acceptance_of(:terms) }
  it { is_expected.to belong_to(:designation) }
end
