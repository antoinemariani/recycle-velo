class DashboardsController < ApplicationController
  def profile
    # curren_user peut accéder à ses bikes
    @bikes = Bike.where(user_id: current_user.id)
  end
end
