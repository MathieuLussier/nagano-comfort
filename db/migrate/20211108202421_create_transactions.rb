class CreateTransactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.decimal :sub_total
      t.datetime :transaction_date

      t.references :reservation, null: false, index: true, foreign_key: true
      t.references :customer, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :transactions
  end
end
