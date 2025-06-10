class VehiclesController < ApplicationController
    
    before_action :require_user_logged_in!
    before_action :require_provider!, except: [:index]

    def index 
        @station = RentalStation.find(params[:id])
        @vehicles = @station.vehicles
        
    end

    def new 
        @station = RentalStation.find(params[:id])
        @vehicle = @station.vehicles.new
    end

    def create
        @station = RentalStation.find(params[:id])
        @vehicle = @station.vehicles.new(vehicle_params)
        
        if @vehicle.save
            redirect_to rental_station_vehicles_path(@station), notice: "Vehicle created successfully."
        else
            render :new, alert: "Failed to create vehicle."
        end
    end


    def edit
        @station = RentalStation.find(params[:id])
        @vehicle = @station.vehicles.find(params[:vehicle_id])
    end

    def update  
        @station = RentalStation.find(params[:id])
        @vehicle = @station.vehicles.find(params[:vehicle_id])
        if @vehicle.update(vehicle_params)
            redirect_to dashboard_my_vehicles_path(@station), notice: "Vehicle updated successfully."
        else
            render :edit, alert: "Failed to update vehicle."
        end
    end

    def destroy
        @station = RentalStation.find(params[:id])
        @vehicle = @station.vehicles.find(params[:vehicle_id])
        if @vehicle.destroy
            redirect_to rental_station_vehicles_path(@station), notice: "Vehicle deleted successfully."
        else
            redirect_to rental_station_vehicles_path(@station), alert: "Failed to delete vehicle."
        end
    end


    private

    def vehicle_params
        params.require(:vehicle).permit(:name, :condition, :image_url, :rental_station_id, :price_per_hour,:available)
    end


end
