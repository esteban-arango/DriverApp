require 'faker'

puts "\e[32m CREATING RIDERS \e[0m"

Rider.create(email: 'rider@gmail.com', password: '12345678').email
20.times do
	data = {email: Faker::Internet.email, password: Faker::Crypto.md5}
	user = UserContract.new.call(data)
	puts Rider.create(user.to_h).email if user.success?
end

puts "\e[32m CREATING DRIVERS \e[0m"

Driver.create(email: 'driver@gmail.com', password: '12345678').email
20.times do
	data = {email: Faker::Internet.email, password: Faker::Crypto.md5}
	user = UserContract.new.call(data)
	puts Driver.create(user.to_h).email if user.success?
end