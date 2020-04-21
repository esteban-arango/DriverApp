class PaymentSource < ActiveRecord::Base
  belongs_to :rider
  has_many :rides
end
