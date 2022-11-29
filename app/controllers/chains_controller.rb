class ChainsController < ApplicationController
  before_action :set_bike, only: %i[index show create]

  def index
    @chains = @bike.chains
  end

  def show
    @chain = Chain.find(params[:id])
  end

  def create
    @chain = Chain.new(chain_params)
    @chain.user = current_user
    @chain.bike = @bike
    redirect_to bike_path(@bike)
    if @chain.save!
      redirect_to bike_path(@bike)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @chain = Chain.find(params[:id])
  end

  def update
    @chain = Chain.find(params[:id])
    @chain.user = current_user
    @chain.bike = @bike
    @chain.update!(chain_params)
    redirect_to bike_path(@bike)
  end

  def destroy
    @chain = Chain.find(params[:id])
    @chain.destroy!
    redirect_to bike_path(@bike), status: :see_other
  end

  private

  def chain_params
    params.require(:chain).permit(:bike_id, :state, :broken, :rust, :derail, :chainlink)
  end

  def set_bike
    @bike = Bike.find(params[:id])
  end
end
