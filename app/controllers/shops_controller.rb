class ShopsController < ApplicationController
  def index
    @shops = Shop.where.not(latitude: nil, longitude: nil)
    @markers = @shops.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude#,
        # infoWindow: { content: render_to_string(partial: "/shops/map_box", locals: { shop: shop }) }
        # Uncomment the above line if you want each of your markers to display a info window when clicked
        # (you will also need to create the partial "/shops/map_box")
      }
    end
  end
end
