require './app/models/user.rb'

class Driver < User
  has_many :rides
  scope :availables, -> { where(driver_available: true) }

  def finish_ride(params)
    result = false
    ride = Ride.find_by(id: params[:ride_id])
    from = [ride.latitude, ride.longitude]
    to   = [params[:latitude], params[:longitude]]

    amount = Driver.calculate_price(from, to)
    if ride.in_progress? && Wompi.generate_transaction(ride, amount)
      ride.finished_ride
      result = true
    end
    result
  end

  def self.calculate_price(from, to)
    km = Geocoder::Calculations.distance_between(from, to, units: :km)
    traffic = 60 # 60 Km/h
    minutes = (km / traffic) * 60
    price = (km * 1000) + (200 * minutes) + 3500
    price.to_i
  end
end
