Rails.application.routes.draw do

  get "sign_up" , to: "registrations#new"
  post "sign_up" , to: "registrations#create"

  get "sign_in" , to: "sessions#new" 
  post "sign_in" , to: "sessions#create"

  get "/dashboard/password" , to: "passwords#edit" ,as: :edit_password
  patch "/dashboard/password" , to: "passwords#update"

  get "/dashboard", to: "dashboards#new", as: "dashboard"

  get "/dashboard/rental_stations", to: "dashboards#rental_stations", as: "dashboard_rental_stations"

  get "/dashboard/rental_stations/new", to: "rental_stations#new", as: "new_rental_station"
  post "/dashboard/rental_stations", to: "rental_stations#create"



  get "/rental_stations", to: "rental_stations#all", as: "rental_stations"
  get "/rental_stations/:id", to: "rental_stations#show", as: "rental_station"

  delete "/rental_stations/:id", to: "rental_stations#destroy", as: "delete_rental_station"

  get "/rental_stations/:id/edit", to: "rental_stations#edit" , as: "edit_rental_station"
  patch "/rental_stations/:id" , to: "rental_stations#update"


  get "/rental_stations/:id/vehicles" ,  to:"vehicles#index", as: "rental_station_vehicles"

  get "/rental_stations/:id/vehicles/new", to: "vehicles#new", as: "new_rental_station_vehicle"
  post "/rental_stations/:id/vehicles", to: "vehicles#create" 


  get "/rental_stations/:id/vehicles/:vehicle_id/edit", to: "vehicles#edit", as: "edit_rental_station_vehicle"
  patch "/rental_stations/:id/vehicles/:vehicle_id", to: "vehicles#update" , as: "rental_station_vehicle"

  delete "/rental_stations/:id/vehicles/:vehicle_id", to: "vehicles#destroy", as: "delete_rental_station_vehicle"

  delete "logout" , to:"sessions#destroy"

  get "/dashboard/my_vehicles", to: "dashboards#my_vehicles", as: "dashboard_my_vehicles"

  root to:"main#index"
end
