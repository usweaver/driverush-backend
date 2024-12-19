class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.references :rental_agency, null: false, foreign_key: true
      t.string :model
      t.string :range
      t.references :brand, null: false, foreign_key: true
      t.string :car_type
      t.string :drivetrain
      t.string :gearbox
      t.string :fuel_type
      t.string :efficiency
      t.integer :autonomy
      t.integer :horsepower
      t.integer :torque
      t.integer :acceleration
      t.integer :seating_capacity
      t.integer :trunk
      t.integer :frunk
      t.integer :price_per_day

      t.timestamps
    end
  end
end
