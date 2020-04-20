require 'dry-validation'

class RideContract < Dry::Validation::Contract
    schema do
      required(:latitude).value(:float)
      required(:longitude).value(:float)
      required(:ride_id).value(:integer)
    end
end