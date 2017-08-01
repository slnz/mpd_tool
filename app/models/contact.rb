# frozen_string_literal: true

class Contact < ApplicationRecord
  has_many :donations, dependent: :destroy
  validates :code, uniqueness: true, allow_nil: true
  validates :name, presence: true
end
