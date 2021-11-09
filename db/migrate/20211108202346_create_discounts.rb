class CreateDiscounts < ActiveRecord::Migration
  def up
    create_table :discounts do |t|
      t.string :name, null: false
      t.decimal :discount_amount, null: false
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end
  end

  def down
    drop_table :discounts
  end
end
