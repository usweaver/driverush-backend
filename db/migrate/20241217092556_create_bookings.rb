class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :car, null: false, foreign_key: true
      t.uuid :user
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
