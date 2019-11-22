class Rental < ApplicationRecord
  before_create :generate_reservation_code
  enum status: { scheduled: 0, ongoing: 1, finalized: 2 }
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  validates :start_date, :end_date, :price_projection, presence: true
  validate :start_cannot_be_greater_than_end, :cars_available, :price_cannot_be_zero

  def calculate_price_projection
    return 0 unless start_date && end_date && category
    days = (end_date - start_date).to_i
    value = category.daily_rate + category.car_insurance +
      category.third_party_insurance
    days * value
  end

  def start_cannot_be_greater_than_end
    return 0 if start_date.nil? || end_date.nil?
    if start_date > end_date
      errors.add(:start_date, 'não pode ser maior que data de término.')
    end
  end

  def cars_available
    if cars_available_at_date_range
      errors.add(:category, 'Não há carros disponíveis na categoria escolhida.')
    end
  end

  def price_cannot_be_zero
    if price_projection <= 0
      errors.add(:price_projection, 'não pode ser zero.')
    end
  end

  private

  def cars_available_at_date_range
    scheduled_rentals = Rental.where(category: category)
      .where(start_date: start_date..end_date)
      .or(Rental.where(category: category)
      .where(end_date: start_date..end_date))

    available_cars_at_category = Car.where(status: :available).joins(:car_model)
      .where(car_models: { category: category })
    scheduled_rentals.count >= available_cars_at_category.count
  end

  def generate_reservation_code
    self.reservation_code = loop do
      token = generate_random_token
      break token unless Rental.exists?(reservation_code: token)
    end
  end

  def generate_random_token
    charset = Array('A'..'Z') + Array(0..9)
    Array.new(6) { charset.sample }.join
  end
end
