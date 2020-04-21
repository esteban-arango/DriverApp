class Ride < ActiveRecord::Base
  belongs_to :rider
  belongs_to :driver
  belongs_to :payment_source

  before_create :set_driver
  enum status: { in_progress: 0, finished: 1 }.freeze
  enum payment_status: { pending: 0, paid: 1 }.freeze

  def set_driver
    rand_id = (ENV['SINATRA_ENV'] == 'development' ? rand(Driver.count) : 1) # Random in production, first in dev
    driver  = Driver.availables.where('id >= ?', rand_id).first
    driver.update_column(:driver_available, false) if driver.present?
    self.driver = driver
  end

  def finished_ride
    driver.update_column(:driver_available, true) if driver.present?
    finished!
    paid!
  end
end
