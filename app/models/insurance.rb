class Insurance < ApplicationRecord
  belongs_to :category
  validates :name, :daily_rate, presence: true
  validates :daily_rate, numericality: { greater_than: 0 }
end
