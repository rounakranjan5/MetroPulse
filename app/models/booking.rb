class Booking < ApplicationRecord
      belongs_to :vehicle
      belongs_to :rental_station
      belongs_to :customer, class_name: 'User'
      belongs_to :provider, class_name: 'User'
      has_one :payment

      validates :vehicle_type, :duration, :price, :booking_date, presence: true
end
