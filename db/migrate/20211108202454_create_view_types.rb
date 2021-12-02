class CreateViewTypes < ActiveRecord::Migration
  def up
    create_table :view_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end

  def down
    drop_table :view_types
  end
end
