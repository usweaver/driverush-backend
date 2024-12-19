class RentalAgency < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :bookings, through: :cars

  validates :name, :agency_type, :address, :zipcode, :city, :opening_hours, presence: true

  validates :agency_type, inclusion: { in: %[airport train_station] }
end
