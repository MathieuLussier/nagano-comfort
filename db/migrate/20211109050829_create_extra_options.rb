class CreateExtraOptions < ActiveRecord::Migration
  def up
    create_table :extra_options do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :is_billable, null: false
      t.decimal :price

      t.timestamps
    end
  end

  def down
    drop_table :extra_options
  end
end
