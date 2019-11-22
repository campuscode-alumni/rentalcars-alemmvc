class Car < ApplicationRecord
  enum status: { available: 0, unavailable: 10 }
  belongs_to :car_model
  has_one :category, through: :car_model
  validates :car_km, presence: true
  validates :color, presence: true
  validates :license_plate, presence: true
end
