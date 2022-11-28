class CreateChains < ActiveRecord::Migration[7.0]
  def change
    create_table :chains do |t|
      t.references :bike, null: false, foreign_key: true
      t.string :state
      t.boolean :broken
      t.boolean :rust
      t.boolean :derail
      t.string :chainlink

      t.timestamps
    end
  end
end
