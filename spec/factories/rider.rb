FactoryBot.define do
  factory :rider do
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
  end
end