class Ride < ActiveRecord::Base
	belongs_to :rider
	belongs_to :driver
	belongs_to :payment_source

	before_create :set_driver
	enum status: { in_progress: 0, finished: 1 }.freeze
	enum payment_status: { pending: 0, paid: 1 }.freeze

	def set_driver
		rand_id = rand(Driver.count)
		self.driver = Driver.availables.where("id >= ?", rand_id).first
	end
end
