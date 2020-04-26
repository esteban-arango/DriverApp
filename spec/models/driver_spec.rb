require_relative '../spec_helper'

describe Driver, type: :model do
  describe 'factory test' do
    let(:driver) { create :driver }
    it 'should to test the driver factory' do
      expect(driver).to be_valid
      expect(driver.persisted?).to be true
    end
  end

  describe 'associations' do
    it { should have_many(:rides) }
  end

  describe '.availables' do
    let(:available_driver) { create :driver }
    let(:no_available_driver) { create :driver, driver_available: false }

    it 'includes drivers with driver_available in true' do
      expect(Driver.availables).to include(available_driver)
    end

    it 'excludes drivers without driver_available in true' do
      expect(Driver.availables).not_to include(no_available_driver)
    end
  end

  describe '#finish_ride' do
    let(:ride) { create :ride, transaction_id: nil }
    let(:ride_finished) { create :ride, status: 1 }

    it 'when is successful' do
      params = { ride_id: ride.id, latitude: ride.latitude, longitude: ride.longitude }
      response = ride.driver.finish_ride(params)
      expect(response[:success]).to be true
      expect(response[:data][:status]).to eq('APPROVED')
    end

    it 'when ride is finished' do
      params = { ride_id: ride_finished.id, latitude: ride_finished.latitude, longitude: ride_finished.longitude }
      response = ride_finished.driver.finish_ride(params)
      expect(response[:success]).to be false
    end
  end

  describe '.calculate_price' do
    it 'when there is distance between the coordinates' do
      from = [6.2568693, -75.5923187]
      to   = [6.1707687, -75.4298088]
      expect(Driver.calculate_price(from, to)).to eq(27_927)
    end
    it 'when there is no distance between the coordinates' do
      from = [6.2568693, -75.5923187]
      expect(Driver.calculate_price(from, from)).to eq(3500)
    end
  end
end
