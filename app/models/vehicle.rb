class Vehicle < ApplicationRecord
  belongs_to :rental_station
  has_many :bookings
  
  validates :name, :condition, presence: true
end
