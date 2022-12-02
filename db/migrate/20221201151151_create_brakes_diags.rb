class CreateBrakesDiags < ActiveRecord::Migration[7.0]
  def change
    create_table :brakes_diags do |t|
      t.references :brake, null: false, foreign_key: true
      t.string :braking
      t.string :handle
      t.string :pad
      t.string :wire
      t.string :squeak

      t.timestamps
    end
  end
end
