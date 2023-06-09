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

  scope :available,-> (start_date, end_date) {
    where.not(
      id: Booking
        .where("(start_date <= :start_date AND end_date >= :start_date) OR (start_date <= :end_date AND end_date >= :end_date) OR (start_date >= :start_date AND end_date <= :end_date)", start_date: start_date, end_date: end_date)
        .pluck(:car_id)
    )
  }
end
