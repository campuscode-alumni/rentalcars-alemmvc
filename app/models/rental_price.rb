class RentalPrice < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :category
  validates :daily_rate, :daily_car_insurance, :daily_third_party_insurance, presence: true
end
