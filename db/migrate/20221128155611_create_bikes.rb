class CreateBikes < ActiveRecord::Migration[7.0]
  def change
    create_table :bikes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :model
      t.string :brand

      t.timestamps
    end
  end
end
