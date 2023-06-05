class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :year, :price, :seats_number, :availability, presence: true
end
