class CreateBedroomStatuses < ActiveRecord::Migration
  def up
    create_table :bedroom_statuses do |t|
      t.string :name, null: false

      t.timestamps
    end
  end

  def down
    drop_table :bedroom_statuses
  end
end
