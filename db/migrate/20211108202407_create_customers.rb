class CreateCustomers < ActiveRecord::Migration
  def up
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def down
    drop_table :customers
  end
end
