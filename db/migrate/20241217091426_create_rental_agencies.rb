class CreateRentalAgencies < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_agencies do |t|
      t.string :name
      t.string :address
      t.integer :zipcode
      t.string :city
      t.string :opening_hours

      t.timestamps
    end
  end
end
