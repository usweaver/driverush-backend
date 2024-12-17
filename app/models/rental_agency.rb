class RentalAgency < ApplicationRecord
  has_many :cars
  has_many :bookings, through: :cars

  validates :name, :address, :zipcode, :city, :opening_hours, presence: true
end
