class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  include PgSearch::Model
  multisearchable against: [:price, :seats_number, :model]

  # Associations
  belongs_to :user
  has_many_attached :photos
  has_many :bookings

  # Validations
  validates :year, :price, :seats_number, presence: true
  # validates :photos, presence: true
end
