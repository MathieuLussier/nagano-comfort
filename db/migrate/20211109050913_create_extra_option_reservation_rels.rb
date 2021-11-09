class CreateExtraOptionReservationRels < ActiveRecord::Migration
  def up
    create_table :extra_option_reservation_rels, id: false do |t|
      t.references :extra_option, null: false, index: true, foreign_key: true
      t.references :reservation, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :extra_option_reservation_rels
  end
end
