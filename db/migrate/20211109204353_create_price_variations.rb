class CreatePriceVariations < ActiveRecord::Migration
  def up
    create_table :price_variations do |t|
      t.string :name, null: false
      t.decimal :variation_amount, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.integer :day_of_week, default: 0
      t.boolean :is_discount, default: false, null: false

      t.timestamps
    end
  end

  def down
    drop_table :price_variations
  end
end
