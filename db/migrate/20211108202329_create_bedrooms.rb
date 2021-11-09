class CreateBedrooms < ActiveRecord::Migration
  def up
    create_table :bedrooms do |t|
      t.string :name, null: false
      t.integer :nb_of_beds, null: false
      t.decimal :price_per_night, null: false

      t.references :bedroom_type, null: false, index: true, foreign_key: true
      t.references :bedroom_status, null: false, index: true, foreign_key: true
      t.references :view_type, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :bedrooms
  end
end
