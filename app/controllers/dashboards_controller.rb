class DashboardsController < ApplicationController
    before_action :require_user_logged_in!


    def new 
        @user = Current.user
    end

    def rental_stations
  @rental_stations = RentalStation.where(user_id: Current.user.id)
    end

    def my_vehicles
      @vehicles = Vehicle.joins(:rental_station).where(rental_stations: { user_id: Current.user.id })
      @stations = RentalStation.where(user_id: Current.user.id)
  end

end