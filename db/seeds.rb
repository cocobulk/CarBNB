require "faker"
require "open-uri"

puts "deleting existing data"
Booking.destroy_all
Car.destroy_all
User.destroy_all
puts "done deleting existing data"

puts "creating ten users, cars, and bookings"

bookings = []
cars = []
users = []
images_urls = []
10.times do |count|
  users << User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)
  cars << Car.create!(model: "Fiat", year: 2021, price: Faker::Commerce.price, seats_number: count + 1, availability: true, user_id: users[count].id, address: Faker::Address.city)
  bookings << Booking.create!(start_date: "2021-01-01", end_date: "2021-01-02", confirmed: false, car_id: cars[count].id, user_id: users[count].id)
  puts "created a user, car, and booking"
end
puts "done creating users, cars, and bookings"

puts "Now, fetching 3 photos..."
3.times do
  images_urls << Faker::LoremFlickr.image(size: "250x260", search_terms: ["cars"])
end
puts "done fetching photos"

puts "adding photos to cars"
cars.each do |car|
  images_urls.each do |url|
    file = URI.open(url)
    car.photos.attach(io: file, filename: "car.png", content_type: "image/png")
    puts "added photo to car #{car.id}"
  end
end
puts "done adding photos to cars"
