require 'rails_helper'

RSpec.describe Donation::Fetch, type: :model do
  before do
    ENV['DATASERVE_USERNAME'] = 'projects@example.com'
    ENV['DATASERVE_PASSWORD'] = 'example_password'
    Timecop.freeze(Time.parse('Oct 14 2014'))
    VCR.insert_cassette 'models/donation/fetch'
  end

  describe 'self#from_dataserve' do
    it 'generates projects' do
      expect { Donation::Fetch.from_dataserve(1.month) }.to(
        change { Project.count }.from(0).to(8)
      )
    end
    it 'is successful' do
      expect { Donation::Fetch.from_dataserve(1.month) }.to(
        change { Donation.count }.from(0).to(288)
      )
    end
  end

  describe 'self#create_donation' do
    let(:donation) { attributes_for(:donation) }
    let(:data) do
      {
        'DONATION_ID' => donation[:global_id],
        'PEOPLE_ID' => 3423,
        'ACCT_NAME' => Faker::Name.name,
        'DESIGNATION' => donation[:designation_id],
        'TENDERED_AMOUNT' => donation[:amount],
        'DISPLAY_DATE' => donation[:display_date].strftime('%m/%d/%Y'),
        'PAYMENT_METHOD' => donation[:payment_method]
      }
    end
    it 'creates donation' do
      expect { Donation::Fetch.create_donation data, create(:project) }.to(
        change { Donation.count }.from(0).to(1)
      )
      expect { Donation::Fetch.create_donation data, create(:project) }.not_to(
        change { Donation.count }
      )
    end
    it 'creates contact' do
      expect { Donation::Fetch.create_donation data, create(:project) }.to(
        change { Contact.count }.from(0).to(1)
      )
      expect { Donation::Fetch.create_donation data, create(:project) }.not_to(
        change { Contact.count }
      )
    end
  end

  describe 'self#contact' do
    let(:donation) { attributes_for(:donation) }
    let(:data) do
      {
        'PEOPLE_ID' => donation[:contact_id],
        'DESIGNATION' => donation[:designation_id],
        'ACCT_NAME' => Faker::Name.name
      }
    end
    it 'creates contact' do
      expect { Donation::Fetch.contact data }.to(
        change { Contact.count }.from(0).to(1)
      )
      expect { Donation::Fetch.contact data }.not_to(
        change { Contact.count }
      )
    end
  end

  after do
    VCR.eject_cassette 'models/donation/fetch'
  end
end
