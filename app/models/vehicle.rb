class Vehicle < ApplicationRecord
  belongs_to :rental_station
  
  validates :name, :condition, presence: true
end
