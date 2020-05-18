class RentalCalculator
  def self.calculate(rental)
    new(rental).calculate()
  end


  def calculate()
    return 0 unless rental.start_date && rental.end_date && rental.category
    total_days * category_price
  end

  private

  attr_reader :rental

  def initialize(rental)
    @rental = rental
  end

  
  def total_days
    days = (rental.end_date - rental.start_date).to_i
    days > 0 ? days : 1
  end

  def category_price
    rental.category.daily_rate
  end
end