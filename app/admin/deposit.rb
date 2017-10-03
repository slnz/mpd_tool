# frozen_string_literal: true

ActiveAdmin.register Deposit do
  config.per_page = 100
  scope :all
  scope :pending, default: true
  scope :complete
  decorate_with Decorator::DepositDecorator

  index do
    selectable_column
    id_column
    column(:designation) do |d|
      link_to d.designation.designation_code, admin_designation_path(d.designation)
    end
    column(:donor, &:name)
    column(:donee) { |d| d.designation.name }
    column :project
    column :display_date
    column(:amount) { |d| number_to_currency d.amount }
    column :giving_method
    actions
  end

  batch_action :approve, confirm: 'This action is irreversible. Are You sure you want to do this?' do |ids, _inputs|
    scoped_collection.find(ids).each do |deposit|
      deposit.complete! if deposit.valid?
    end
    redirect_to collection_path, notice: 'The deposits you selected have been marked as complete!'
  end
end
