class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :item
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :user
      t.timestamps
    end
  end
end
