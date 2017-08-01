# frozen_string_literal: true

class Campus < ApplicationRecord
  has_many :designations, dependent: :nullify
  validates :name, presence: true
end
