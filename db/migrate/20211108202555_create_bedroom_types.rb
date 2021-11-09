class CreateBedroomTypes < ActiveRecord::Migration
  def up
    create_table :bedroom_types do |t|
      t.string :key, null: false
      t.string :label, null: false

      t.timestamps
    end
  end

  def down
    drop_table :bedroom_types
  end
end
