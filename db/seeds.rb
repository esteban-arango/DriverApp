require 'faker'

puts "\e[32m CREATING RIDERS \e[0m"

Rider.create(email: 'rider@gmail.com', password: '12345678').email
20.times do
	puts Rider.create(email: Faker::Internet.email, password: Faker::Crypto.md5).email
end

puts "\e[32m CREATING DRIVERS \e[0m"

Driver.create(email: 'driver@gmail.com', password: '12345678').email
20.times do
	puts Driver.create(email: Faker::Internet.email, password: Faker::Crypto.md5).email
end