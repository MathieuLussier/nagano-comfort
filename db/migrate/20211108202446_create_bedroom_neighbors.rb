class CreateBedroomNeighbors < ActiveRecord::Migration
  def up
    create_table :bedroom_neighbors, id: false do |t|
      t.references :bedroom, null: false, index: true, foreign_key: true
      t.references :neighbor, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :bedroom_neighbors
  end
end
