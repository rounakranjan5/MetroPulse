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
  @rental_stations = RentalStation.paginate(page: params[:page], per_page: 6).where(user_id: Current.user.id)

    end

    def my_vehicles
      @vehicles = Vehicle.paginate(page: params[:page], per_page: 6).joins(:rental_station).where(rental_stations: { user_id: Current.user.id })

      @stations = RentalStation.where(user_id: Current.user.id)

      if params[:search].present?
            search_term = "%#{params[:search].strip}%"
            @vehicles = @vehicles.where(
              "LOWER(vehicles.name) LIKE ? OR LOWER(vehicles.condition) LIKE ? OR LOWER(vehicles.available) LIKE ? ", 
              search_term.downcase, search_term.downcase, search_term.downcase
            )
        end

    
    
        if params[:condition].present?
            @vehicles = @vehicles.where(condition: params[:condition])
        end
    
        if params[:status].present?
            @vehicles = @vehicles.where(available: params[:status])
        end


        if params[:min_price].present? && params[:max_price].present?
            @vehicles = @vehicles.where(price_per_hour: params[:min_price]..params[:max_price])
        elsif params[:min_price].present?
            @vehicles = @vehicles.where("price_per_hour >= ?", params[:min_price])
        elsif params[:max_price].present?
            @vehicles = @vehicles.where("price_per_hour <= ?", params[:max_price])
        end

    
        @vehicles = @vehicles.order(created_at: :asc)
  end

  def all_bookings
  if Current.user.role == 'Provider'
    @bookings = Booking.paginate(page: params[:page], per_page: 10).where(provider_id: Current.user.id)
  else
    @bookings = Booking.paginate(page: params[:page], per_page: 10).where(customer_id: Current.user.id)
  end
  
  if params[:search].present?
    search_term = "%#{params[:search].strip}%"
    @bookings = @bookings.joins("LEFT JOIN vehicles ON vehicles.id = bookings.vehicle_id")
                         .where("vehicles.name LIKE ? OR bookings.vehicle_type LIKE ?", 
                                search_term, search_term)
  end
  
  if params[:booking_date].present?
    search_date = Date.parse(params[:booking_date])
    @bookings = @bookings.where("DATE(booking_date) = ?", search_date)
  end
  
  if params[:min_price].present?
    @bookings = @bookings.where("price >= ?", params[:min_price])
  end
  
  if params[:max_price].present?
    @bookings = @bookings.where("price <= ?", params[:max_price])
  end
  
  @filtered_bookings = 
    case params[:filter]
    when "completed"
      @bookings.where(status: "completed")
    when "accepted"
      @bookings.where(status: "accepted")
    when "canceled"
      @bookings.where(status: "canceled")
    else
      @bookings.where(status: "pending")
    end
  
  case params[:sort]
    when "date_asc"
      @filtered_bookings = @filtered_bookings.order(booking_date: :asc)
    when "date_desc"
      @filtered_bookings = @filtered_bookings.order(booking_date: :desc)
    when "price_asc"
      @filtered_bookings = @filtered_bookings.order(price: :asc)
    when "price_desc"
      @filtered_bookings = @filtered_bookings.order(price: :desc)
    else
      @filtered_bookings = @filtered_bookings.order(created_at: :desc)
  end
  

end
end