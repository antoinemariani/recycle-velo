class AddBikeToWheels < ActiveRecord::Migration[7.0]
  def change
    add_reference :wheels, :bike, null: false, foreign_key: true
  end
end
