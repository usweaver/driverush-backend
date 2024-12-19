# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
require "json"
require "yaml"

puts "Start seeding 🏎️"

Booking.destroy_all
Car.destroy_all
Brand.destroy_all
RentalAgency.destroy_all

brands = YAML.load_file(Rails.root.join('db', 'seeds_data', 'brands.yml'))['brands'].map { |brand| brand.transform_keys(&:to_sym) }

brands.each do |brand|
  new_brand = Brand.create!(name: brand[:name], description: brand[:description], range_level: brand[:range_level])
  file = URI.parse(brand[:logo_url]).open
  new_brand.logo.attach(io: file, filename: "#{brand[:name]}.png", content_type: "image/png")
end

puts "#{Brand.all.count} brand#{"s" if Brand.all.count > 1} created : #{Brand.all.map(&:name).join(", ")}"

rental_agencies = [
  {
    name: "Gare Part-dieu",
    agency_type: "train_station",
    address: "6, Place Charles Béraudier",
    zipcode: 69003,
    city: "Lyon",
    opening_hours: "7h - 00h"
  },
  {
    name: "Aéroport Lyon Saint-Exupéry",
    agency_type: "airport",
    address: "Aéroport de Lyon-Saint-Exupéry",
    zipcode: 69125,
    city: "Colombier-Saugnieu",
    opening_hours: "7h - 00h"
  }
]

rental_agencies.each do |rental_agency|
  RentalAgency.create!(name: rental_agency[:name], agency_type: rental_agency[:agency_type], address: rental_agency[:address], zipcode: rental_agency[:zipcode], city: rental_agency[:city], opening_hours: rental_agency[:opening_hours])
end

puts "#{RentalAgency.all.count} rental agenc#{RentalAgency.all.count > 1 ? "ies" : "y"} created : #{RentalAgency.all.map(&:name).join(", ")}"

cars = YAML.load_file(Rails.root.join('db', 'seeds_data', 'cars.yml'))['cars'].map { |car| car.transform_keys(&:to_sym) }

cars.each do |car|
  main_file = URI.parse(car[:main_picture_url]).open
  files = []
  car[:pictures_url].each do |picture_url|
    files << URI.parse(picture_url).open
  end
  RentalAgency.all.each do |rental_agency|
    new_car = Car.create!(
      rental_agency: rental_agency,
      model: car[:model],
      range: car[:range],
      brand: Brand.find_by(name: car[:brand]),
      car_type: car[:car_type],
      drivetrain: car[:drivetrain],
      gearbox: car[:gearbox],
      fuel_type: car[:fuel_type],
      efficiency: car[:efficiency],
      autonomy: car[:autonomy],
      horsepower: car[:horsepower],
      torque: car[:torque],
      acceleration: car[:acceleration],
      seating_capacity: car[:seating_capacity],
      trunk: car[:trunk],
      frunk: car[:frunk],
      price_per_day: car[:price_per_day]
      )
    new_car.main_picture.attach(io: main_file, filename: "main #{car[:brand].downcase} #{car[:model].downcase}.jpg", content_type: "image/jpg")
    files.each_with_index do |file, index|
      new_car.pictures.attach(io: file, filename: "#{car[:brand].downcase} #{car[:model].downcase} #{index}.jpg", content_type: "image/jpg")
    end
  end
end


puts "#{Car.all.count} car#{"s" if Car.all.count > 1} created"

puts "Seeding finished 🏁"
