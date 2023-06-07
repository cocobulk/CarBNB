class Car < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_many :bookings
  validates :year, :price, :seats_number, presence: true

  # attribute :address, :string
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :photos, presence: true
end
