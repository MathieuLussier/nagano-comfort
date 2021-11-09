class CreateReservations < ActiveRecord::Migration
  def up
    create_table :reservations do |t|
      t.text :description

      t.datetime :in_date, null: false
      t.datetime :out_date

      t.integer :nb_guests
      t.integer :duration

      t.references :customer, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :reservations
  end
end
