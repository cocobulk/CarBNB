require 'faker'


count = 1
bookings = []
cars = []
users = []
10.times do
  users << User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)
  cars << Car.create!(model: "Ford" ,year: 2021, price: "$#{Faker::Commerce.price}", seats_number: count, availability: true, user_id: count)
  bookings << Booking.create!(start_date: "2021-01-01", end_date: "2021-01-02", confirmed: true, car_id: count, user_id: count)
  count += 1
end
