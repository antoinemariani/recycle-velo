class BikesController < ApplicationController
  before_action :set_bike, only: %I[show edit update destroy results]

  def index
    @bikes = Bike.where(user: current_user)
    @bike = Bike.new
  end

  def show
    @chain = Chain.new(bike: @bike)
    @chains = Chain.where(bike: @bike)
    @wheel = Wheel.new(bike: @bike)
    @wheels = Wheel.where(bike: @bike)
    @brake = Brake.new(bike: @bike)
    @brakes = Brake.where(bike: @bike)
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    @bike.save!
    flash[:success] = "Votre nouveau vélo a bien été ajouté !"
    redirect_to bikes_path
  end

  def edit; end

  def update
    @bike.user = current_user
    @bike.update!(bike_params)
    redirect_to bike_path(@bike)
  end

  def destroy
    @bike.destroy!
    redirect_to bikes_path, status: :see_other
  end

  def results
    # note globale du vélo
    ChainsDiag.where(chain: @bike.chains.last).last.nil? ? chain_note = 2 : chain_note = ChainsDiag.where(chain_id: Chain.where(bike_id: @bike.id))[0].note
    WheelsDiag.where(wheel: @bike.wheels.last).last.nil? ? wheel_note = 2 : wheel_note = WheelsDiag.where(wheel_id: Wheel.where(bike_id: @bike.id))[0].note

    @bike_note = (((chain_note + wheel_note + 6) / 3) * 10).round
  end

  private

  def bike_params
    params.require(:bike).permit(:name, :model, :brand, :photo)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end
end
