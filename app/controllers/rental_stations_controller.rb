class RentalStationsController < ApplicationController


  before_action :require_user_logged_in! 
  def new
    @rental_station = RentalStation.new
  end

  def create
    @rental_station = RentalStation.new(rental_station_params)
    @rental_station.user_id = Current.user.id  

    if @rental_station.save
      redirect_to dashboard_rental_stations_path, notice: "Rental station created successfully."
    else
      render :new, alert: "Failed to create rental station."
    end
  end

  def all
    @rental_stations = RentalStation.all
  end
  
  def destroy
    @rental_station = RentalStation.find(params[:id])
    
    if @rental_station.user_id == Current.user.id
      @rental_station.destroy
      redirect_to dashboard_rental_stations_path, notice: "Rental station deleted successfully."
    else
      redirect_to dashboard_rental_stations_path, alert: "You are not authorized to delete this rental station."
    end
  end
  
  
def edit
@rental_station = RentalStation.find(params[:id])
  
   
end


def update
  @rental_station = RentalStation.find(params[:id])
  if @rental_station.user_id == Current.user.id
    if @rental_station.update(rental_station_params)
      redirect_to dashboard_rental_stations_path, notice: "Rental station updated successfully."  
    else
      render :edit, alert: "Failed to update rental station."
    end
  else
    redirect_to dashboard_rental_stations_path, alert: "You are not authorized to update this rental station."
  end
end





  private
    def rental_station_params
      params.require(:rental_station).permit(:name, :city, :status, :image_url, :station_type)
    
    end

end
