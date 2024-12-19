class Brand < ApplicationRecord
  has_many :cars, dependent: :destroy

  has_one_attached :logo

  validates :name, :description, :range_level, presence: true

  validates :range_level, inclusion: { in: %[entry_level mid_range premium] }
end
