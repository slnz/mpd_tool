require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to have_db_column(:goal).of_type(:decimal) }
  it { is_expected.to have_many(:designations) }
  it { is_expected.to have_many(:users).through(:designations) }
end
