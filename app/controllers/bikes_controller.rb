class BikesController < ApplicationController
  before_action :set_bike, only: %I[show edit update destroy results]

  def index
    @bikes = Bike.all
  end

  def show
    @chain = Chain.new
    #@chain.bike = @bike
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    @bike.save!
    redirect_to bike_path(@bike)
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
    params.require(:bike).permit(:name, :model, :brand)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end
end
