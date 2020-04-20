require_relative '../spec_helper'

describe Rider, type: :model do
  describe 'factory test' do
    let(:rider) { create :rider }
    it 'should to test the rider factory' do
      expect(rider).to be_valid
      expect(rider.persisted?).to be true
    end
  end

  describe 'associations' do
    it { should have_many(:payment_sources) }
    it { should have_many(:rides) }
  end

  describe '#create_ride' do
    let(:rider) { create :rider }
    it "when is valid params" do
      params = {
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
        payment_source_id: 1
      }
      expect(rider.rides.count).to eq(0)
      rider.create_ride(params)
      expect(rider.rides.count).to eq(1)
    end
  end

  describe '#create_payment_source' do
    let(:rider) { create :rider }
    it "when is valid params" do
      params = {
        number: '4242424242424242',
        cvc: '789',
        exp_month: '12',
        exp_year: '29',
        card_holder: 'Pedro Pérez'
      }

      expect(rider.payment_sources.count).to eq(0)
      rider.create_payment_source(params)
      expect(rider.payment_sources.count).to eq(1)
    end
  end
end
