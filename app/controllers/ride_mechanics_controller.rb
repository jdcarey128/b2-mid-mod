class RideMechanicsController < ApplicationController

  def create
    ride = Ride.find_by_id(params[:ride_search])
    if ride
      RideMechanic.create(ride_id: ride.id, mechanic_id: params[:mechanic_id])
    else
      flash[:error] = "Error: Invalid search query."
    end
    redirect_to "/mechanics/#{params[:mechanic_id]}"
  end

end
