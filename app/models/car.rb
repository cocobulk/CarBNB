class Car < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings
  validates :year, :price, :seats_number, presence: true
end
