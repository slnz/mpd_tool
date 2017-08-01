# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Campus, type: :model do
  it { is_expected.to have_many(:designations).dependent(:nullify) }
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }
end
