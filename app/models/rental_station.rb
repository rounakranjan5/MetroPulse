class RentalStation < ApplicationRecord
  belongs_to :user
    
   
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy

  VALID_CITIES = [
    'Delhi NCR', 'Bangalore', 'Pune', 'Hyderabad', 'Dehradun', 
    'Kolkata', 'Chennai', 'Mumbai', 'Lucknow', 'Jaipur', 
    'Ahmedabad', 'Indore', 'Goa'
  ]

  validates :name, :station_type, presence: true

  validates :city, inclusion: { in: VALID_CITIES, message: "must be a valid city" }

end
