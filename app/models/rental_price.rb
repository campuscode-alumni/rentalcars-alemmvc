class RentalPrice < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :category
  validates :daily_rate, presence: true
end
