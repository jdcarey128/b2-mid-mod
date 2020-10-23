class AmusementParksController < ApplicationController

  def show
    @amusement_park = AmusementPark.find(params[:park_id])
  end

end
