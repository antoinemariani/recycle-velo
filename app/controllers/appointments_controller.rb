class AppointmentsController < ApplicationController
  before_action :set_shop, only: %i[create]

  def create
    @appointment = Appointment.new(appointment_params)
    @bike = Bike.find(@appointment.bike_id)
    @appointment.bike = @bike
    @appointment.user = @appointment.bike.user
    @appointment.shop = @shop
    @appointment.save!
    redirect_to shops_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :bike_id)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
