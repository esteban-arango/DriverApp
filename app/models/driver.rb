require './app/models/user.rb'

class Driver < User
  has_many :rides
  scope :availables, -> { where(driver_available: true) }

  def finish_ride(params)
    result = { success: false, data: 'Ride is not associated with current driver' }
    ride = Ride.find_by(id: params[:ride_id])
    # return result if ride.driver_id != id

    from = [ride.latitude, ride.longitude]
    to   = [params[:latitude], params[:longitude]]

    amount = Driver.calculate_price(from, to)
    transaction = Wompi.generate_transaction(ride, amount)

    if ride.available_to_payment? && transaction[:success]
      ride.finished_ride(transaction[:data])
      result = { success: true, data: transaction[:data] }
    else
      result[:data] = transaction[:data]
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
