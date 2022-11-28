class CreateChainsDiags < ActiveRecord::Migration[7.0]
  def change
    create_table :chains_diags do |t|
      t.references :chain, null: false, foreign_key: true
      t.string :state
      t.string :broken
      t.string :rust
      t.string :derail
      t.string :chainlink

      t.timestamps
    end
  end
end
