class RideController < ApplicationController
  
  def add_passenger
    ride = Ride.find(params[:id])
    ride.add_passenger(User.find(params[:user_id]))
  end
  
  def remove_passenger
    ride = Ride.find(params[:id])
    ride.remove_passenger(User.find(params[:user_id]))
  end
end