class Ride < ActiveRecord::Base
  belongs_to :rider
  belongs_to :driver
  belongs_to :payment_source

  before_create :set_driver
  enum status: { in_progress: 0, finished: 1 }.freeze
  enum payment_status: { pending: 0, paid: 1, failed: 2 }.freeze

  def set_driver
    rand_id = (ENV['SINATRA_ENV'] == 'development' ? rand(Driver.count) : 1) # Random in production, first in dev
    driver  = Driver.availables.where('id >= ?', rand_id).first
    driver.update_column(:driver_available, false) if driver.present?
    self.driver = driver
  end

  def finished_ride(data)
    driver.update_column(:driver_available, true) if driver.present?
    self.transaction_id = data[:id]
    self.status = 'finished'
    self.payment_status = 'paid' if data[:status] == 'APPROVED'
    save
  end

  def available_to_payment?
    in_progress? && pending? && transaction_id.blank?
  end

  def self.update_pending_transaction
    pending_rides = Ride.where(status: 'finished', payment_status: 'pending').where.not(transaction_id: nil)
    pending_rides.each do |ride|
      response = Wompi.get_transaction(ride.transaction_id)
      if response[:success]
        if response[:data] == 'APPROVED'
          ride.paid!
        elsif response[:data] != 'PENDING'
          ride.failed!
        end
      end
    end
  end

  def serialize
    {
      id: id,
      latitude: latitude,
      longitude: longitude,
      status: status,
      payment_status: payment_status,
      payment_source: payment_source.name,
      rider: rider.email,
      driver: driver.email,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
