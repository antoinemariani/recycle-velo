class CreateWheels < ActiveRecord::Migration[7.0]
  def change
    create_table :wheels do |t|
      t.references :bike, null: false, foreign_key: true
      t.string :puncture
      t.string :bent
      t.string :spoke
      t.string :noise
      t.string :tyre

      t.timestamps
    end
  end
end
