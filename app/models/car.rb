class Car < ApplicationRecord
  belongs_to :rental_agency
  belongs_to :brand
  has_many :bookings, dependent: :destroy

  has_one_attached :main_picture
  has_many_attached :pictures

  validates :model, :range, :car_type, :drivetrain, :gearbox, :fuel_type, :efficiency, :autonomy, :horsepower, :torque, :acceleration, :seating_capacity, :trunk, :price_per_day, presence: true

  validates :autonomy, :horsepower, :torque, :acceleration, :seating_capacity, :trunk, :price_per_day, numericality: { only_integer: true, greater_than: 0 }

  validates :drivetrain, inclusion: { in: %w[awd fwd rwd] }
  validates :gearbox, inclusion: { in: %w[automatic manual] }
  validates :fuel_type, inclusion: { in: %w[electric hybrid_diesel hybrid_petrol mild_hybrid_diesel mild_hybrid_petrol petrol diesel] }
  validates :efficiency, inclusion: { in: %w[a b c d e f] }
  validates :car_type, inclusion: { in: %[hatchback crossover station_wagon suv] }
end
