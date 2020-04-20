FactoryBot.define do
  factory :ride do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    status { 0 }
    payment_status { 0 }
    payment_source_id { 1 }
    rider { create(:rider) }
    driver { create(:driver) }
  end
end