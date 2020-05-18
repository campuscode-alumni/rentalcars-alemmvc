class ScheduledRental
  def initialize(rental)
    @rental = rental
  end
  
  def create
    rental.status = scheduled
    rental.price = RentalCalculator.calculate(rental)
    rental.save()
  end

  def self.all()
    Rental.where(status: :schedule)
  end

  private

  attr_reader :rental
end