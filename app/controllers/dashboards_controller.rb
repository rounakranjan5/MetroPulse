class DashboardsController < ApplicationController
    before_action :require_user_logged_in!

    before_action :require_provider!, except: [ :all_bookings, :new]

    def new 
        @user = Current.user
        if Current.user.role == 'Provider'
        @completed_rentals = Booking.where(provider_id: Current.user.id, status: "completed")
        @upcoming_bookings = Booking.where(provider_id: Current.user.id, status: "accepted")
    else
        @completed_rentals = Booking.where(customer_id: Current.user.id, status: "completed")
        @upcoming_bookings = Booking.where(customer_id: Current.user.id, status: "accepted")
    end
    end

    def rental_stations
  @rental_stations = RentalStation.where(user_id: Current.user.id)
    end

    def my_vehicles
      @vehicles = Vehicle.joins(:rental_station).where(rental_stations: { user_id: Current.user.id })
      @stations = RentalStation.where(user_id: Current.user.id)
  end

  def all_bookings
  @bookings = Booking.where("customer_id = ? OR provider_id = ?", Current.user.id, Current.user.id)
end
end