require "faker"
require "open-uri"

puts "creating ten users, cars, and bookings"

bookings = []
cars = []
users = []
10.times do |count|
  users << User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)
  cars << Car.create!(model: "Fiat", year: 2021, price: Faker::Commerce.price, seats_number: count + 1, availability: true, user_id: users[count].id)
  bookings << Booking.create!(start_date: "2021-01-01", end_date: "2021-01-02", confirmed: false, car_id: cars[count].id, user_id: users[count].id)
  puts "created user #{count + 1}, car #{count + 1}, and booking #{count + 1}"
end
puts "done"

puts "adding photos to cars"
cars.each do |car|
  img_url = Faker::LoremFlickr.image(size: "250x260", search_terms: ["cars"])
  file = URI.open(img_url)
  car.photo.attach(io: file, filename: "car.png", content_type: "image/png")
  puts "added photo to car #{car.id}"
end
puts "done adding photos to cars"
