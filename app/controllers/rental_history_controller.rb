class RentalHistoryController < ApplicationController

    before_action  :require_user_logged_in!

    def show
        if Current.user.role=='Provider'
            @completed_rentals=Booking.where(provider_id: Current.user.id, status: 'completed').order(created_at: :desc)
        else
            @completed_rentals=Booking.where(customer_id: Current.user.id, status: 'completed').order(created_at: :desc)
        end
    end

end