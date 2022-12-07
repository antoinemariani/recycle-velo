class AddNoteToWheelsDiag < ActiveRecord::Migration[7.0]
  def change
    add_column :wheels_diags, :note, :float
  end
end
