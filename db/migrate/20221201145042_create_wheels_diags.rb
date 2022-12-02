class CreateWheelsDiags < ActiveRecord::Migration[7.0]
  def change
    create_table :wheels_diags do |t|
      t.references :wheel, null: false, foreign_key: true
      t.string :puncture
      t.string :bent
      t.string :spoke
      t.string :noise
      t.string :tyre

      t.timestamps
    end
  end
end
