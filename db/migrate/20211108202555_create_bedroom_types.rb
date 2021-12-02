class CreateBedroomTypes < ActiveRecord::Migration
  def up
    create_table :bedroom_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end

  def down
    drop_table :bedroom_types
  end
end
