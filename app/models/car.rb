class Car < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_many :bookings
  validates :year, :price, :seats_number, presence: true
  validates :photos, presence: true
end
