require 'rails_helper'

RSpec.describe DesignationMailer, type: :mailer do
  let(:designation) { build(:designation, activation_code: 'CD234') }
  let(:mail) { DesignationMailer.send_activation_code(designation) }

  it 'renders the subject' do
    expect(mail.subject).to eq('Go Summer Project: Get Started with MPD')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([designation.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['projects@studentlife.org.nz'])
  end

  it 'renders @designation.first_name' do
    expect(mail.body.encoded).to match(/#{designation.first_name}/)
  end

  it 'renders @designation.activation_code' do
    expect(mail.body.encoded).to match(/#{designation.activation_code}/)
  end
end
