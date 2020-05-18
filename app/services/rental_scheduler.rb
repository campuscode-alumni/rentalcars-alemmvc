class RentalScheduler
  def initialize(rental, calculator = RentalCalculator)
    @rental = rental
    @calculator = calculator
  end

  def schedule
    return false unless subsidiary?
    rental.status = :scheduled
    rental.price_projection = calculator.calculate(rental)

    rental.save
  end

  private

  attr_reader :rental, :calculator

  def subsidiary?
    !rental.subsidiary.nil?
  end
end