class AddNoteToBrakesDiag < ActiveRecord::Migration[7.0]
  def change
    add_column :brakes_diags, :note, :float
  end
end
