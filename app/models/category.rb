class Category < ApplicationRecord
  validates :name, :daily_rate, presence: true
  has_many :rental_prices
  has_many :car_models
  has_many :cars, through: :car_models
  has_many :insurances

  def description
    "Categoria #{name}"
  end
end
