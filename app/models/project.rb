# frozen_string_literal: true

class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged finders]
  validates :title, presence: true
  validates :code, presence: true
  has_many :donations, dependent: :nullify
  has_many :designations, dependent: :nullify
  has_many :pledges, dependent: :nullify
  has_many :donees, through: :designations, class_name: 'User::Donee'
  has_many :subscriptions, dependent: :destroy
  scope :opened, -> { where('date >= ?', Time.current) }

  def opened?
    return false unless date
    date >= Time.current
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
