class Category < ApplicationRecord
  validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: true
  has_many :rental_prices
  has_many :car_models
  has_many :cars, through: :car_models
end
