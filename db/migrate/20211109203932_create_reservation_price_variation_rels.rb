class CreateReservationPriceVariationRels < ActiveRecord::Migration
  def up
    create_table :reservation_price_variation_rels, id: false do |t|
      t.references :price_variation, null: false, index: true, foreign_key: true
      t.references :reservation, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :reservation_price_variation_rels
  end
end
