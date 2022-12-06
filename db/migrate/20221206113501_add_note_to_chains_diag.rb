class AddNoteToChainsDiag < ActiveRecord::Migration[7.0]
  def change
    add_column :chains_diags, :note, :float
  end
end
