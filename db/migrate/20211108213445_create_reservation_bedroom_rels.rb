class CreateReservationBedroomRels < ActiveRecord::Migration
  def up
    create_table :reservation_bedroom_rels, id: false do |t|
      t.references :bedroom, null: false, index: true, foreign_key: true
      t.references :reservation, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :reservation_bedroom_rels
  end
end
