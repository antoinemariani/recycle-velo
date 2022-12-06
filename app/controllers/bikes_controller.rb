class BikesController < ApplicationController
  before_action :set_bike, only: %I[show edit update destroy results]

  def index
    @bikes = Bike.where(user: current_user)
    @bike = Bike.new
  end

  def show
    @chain = Chain.new
    @chains = Chain.all
    @wheel = Wheel.new
    @wheels = Wheel.all
    @brake = Brake.new
    @brakes = Brake.all
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

  def results; end

  private

  def bike_params
    params.require(:bike).permit(:name, :model, :brand, :photo)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end
end
