class Car < ApplicationRecord
  belongs_to :rental_agency
  belongs_to :brand
  has_many :bookings, dependent: :destroy
  has_one :rental_agency
  has_one :brand

  has_one_attached :main_picture
  has_many_attached :pictures

  validates :model, :range, :type, :drive, :gearbox, :fuel_type, :autonomy, :horsepower, :torque, :acceleration, :seating_capacity, :trunk, :price_per_day, presence: true

  validates :autonomy, :horsepower, :torque, :acceleration, :seating_capacity, :trunk, :price_per_day, numericality: { only_integer: true, greater_than: 0 }

  validates :drive, inclusion: { in: %w[awd fwd rwd] }
  validates :gearbox, inclusion: { in: %w[automatic manual] }
  validates :fuel_type, inclusion: { in: %w[electric unleaded diesel] }
end
