require 'dry-validation'

class UserContract < Dry::Validation::Contract
  schema do
    required(:email).value(:string)
    required(:password).value(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
    key.failure('email exist') unless User.where(email: value).empty?
  end

  rule(:password) do
    key.failure('must be greater than 2 characters') if value.size < 3
  end
end
