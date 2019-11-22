class Category < ApplicationRecord
  validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: true
  has_many :rental_prices
end
