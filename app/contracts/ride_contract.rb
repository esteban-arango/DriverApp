require 'dry-validation'

class CreateRideContract < Dry::Validation::Contract
  schema do
    required(:latitude).value(:float)
    required(:longitude).value(:float)
    required(:payment_source_id).value(:integer)
  end
end

class GetRideContract < Dry::Validation::Contract
  schema do
    required(:latitude).value(:float)
    required(:longitude).value(:float)
    required(:ride_id).value(:integer)
    optional(:payment_source_id).value(:integer)
  end
end
