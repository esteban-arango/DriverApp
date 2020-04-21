FactoryBot.define do
  factory :driver do
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
    driver_available { true }
  end
end
