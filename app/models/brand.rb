class Brand < ApplicationRecord
  has_many :cars

  validates :name, :description, :range_level, presence: true

  validates :range_level, inclusion: { in: %[entry_level mid_range high_end] }
end
