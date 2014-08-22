class CreateAirBookings < ActiveRecord::Migration
  def change
    create_table :air_bookings do |t|
      t.references :transaction, index: true
      t.datetime :arrival_date
      t.datetime :return_date
      t.string :destination_code
      t.string :notes

      t.timestamps
    end
  end
end
