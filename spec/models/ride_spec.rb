require_relative '../spec_helper'

describe Ride, type: :model do
  describe 'factory test' do
    let(:ride) { create :ride }
    it 'should to test the ride factory' do
      expect(ride).to be_valid
      expect(ride.persisted?).to be true
    end
  end

  describe 'associations' do
    it { should belong_to(:payment_source) }
    it { should belong_to(:rider) }
    it { should belong_to(:driver) }
  end

  describe '#set_driver' do
    let(:ride) { create :ride, driver: nil }
    let(:drivers) { create_list(:driver, 5) }
    it 'when drivers are available' do
      ride.set_driver
      expect(ride.driver.present?).to be true
      expect(ride.driver.driver_available).to be false
    end
  end

  describe '.update_pending_transaction' do
    it 'when transactions are approved' do
      ride = create(:ride)
      Ride.update_pending_transaction
      expect(ride.reload.paid?).to be true
    end
  end

  describe '#finished_ride' do
    let(:ride) { create :ride }
    it 'when payment is success' do
      ride.finished_ride({ status: 'APPROVED', id: '123-abc' })
      expect(ride.finished?).to be true
      expect(ride.paid?).to be true
      expect(ride.driver.driver_available).to be true
    end
    it 'when payment is pending' do
      ride.finished_ride({ status: 'PENDING', id: '123-abc' })
      expect(ride.finished?).to be true
      expect(ride.pending?).to be true
      expect(ride.driver.driver_available).to be true
    end
  end
end
