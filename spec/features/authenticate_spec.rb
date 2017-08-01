# frozen_string_literal: true

require 'rails_helper'
feature 'User Signs in for the first time' do
  scenario 'they see a notice on the home page' do
    visit root_path
    OmniauthHelper.valid_user
    click_link 'Sign In with Facebook'
    expect(page).to(
      have_css('.alert-info',
               'Successfully authenticated from Facebook account.')
    )
  end
end
