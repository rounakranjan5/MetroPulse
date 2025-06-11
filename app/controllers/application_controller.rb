class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  def set_current_user
        if session[:user_id]
            Current.user=User.find_by(id:session[:user_id])
        end
  end


  def require_user_logged_in!

    redirect_to sign_in_path,alert:"You must be signed in to do that" if Current.user.nil?
    
  end

  def require_provider!
    if Current.user.nil?
      redirect_to sign_in_path, alert: "You must be signed in to access this page."
    elsif Current.user.role != 'Provider'
      redirect_to root_path, alert: "You must be a provider to access this page." 
    end
  end

  def require_customer!
   if Current.user.nil?
      redirect_to sign_in_path, alert: "You must be signed in to access this page."
    elsif Current.user.role != 'Customer'
      redirect_to root_path, alert: "You must be a customer to access this page."
    end
  end

  def redirect_if_authenticated
    if Current.user
      redirect_to root_path, notice: "You are already signed in."
    end
  end


  
end
