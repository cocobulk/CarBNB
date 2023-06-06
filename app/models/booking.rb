class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user

  def total_price
    self.car.price * (self.end_date - self.start_date).to_i
  end
end
