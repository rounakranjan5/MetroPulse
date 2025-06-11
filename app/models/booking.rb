class Booking < ApplicationRecord
  belongs_to :rental_station
  belongs_to :vehicle, optional: true
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id', optional: true
  belongs_to :provider, class_name: 'User', foreign_key: 'provider_id', optional: true
  has_one :payment

  validates :vehicle_type, :duration, :price, :booking_date, presence: true
  
  scope :pending,   -> { where(status: "pending") }
  scope :accepted,  -> { where(status: "accepted") }
  scope :completed, -> { where(status: "completed") }
  scope :canceled,  -> { where(status: "canceled") }
end
