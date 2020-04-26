class PaymentSource < ActiveRecord::Base
  belongs_to :rider
  has_many :rides

  def serialize
    {
      id: id,
      name: name,
      brand: brand,
      last_four: last_four,
      card_holder: card_holder,
      active: active,
      rider: rider.email,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
