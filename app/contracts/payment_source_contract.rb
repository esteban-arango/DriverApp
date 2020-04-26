require 'dry-validation'

class PaymentSourceRequestContract < Dry::Validation::Contract
  schema do
    required(:number).value(:string)
    required(:cvc).value(:string)
    required(:exp_month).value(:string)
    required(:exp_year).value(:string)
    required(:card_holder).value(:string)
  end

  rule(:number) do
    key.failure('must be have 16 numbers') if value.size != 16
  end

  rule(:cvc) do
    key.failure('must be have 3 numbers') if value.size != 3
  end

  rule(:exp_month) do
    key.failure('must be have 2 numbers') if value.size != 2
  end

  rule(:exp_year) do
    key.failure('must be have 2 numbers') if value.size != 2
  end
end

class PaymentSourceContract < Dry::Validation::Contract
  schema do
    required(:token).value(:string)
    required(:name).value(:string)
    required(:brand).value(:string)
    required(:last_four).value(:string)
    required(:card_holder).value(:string)
  end
end
