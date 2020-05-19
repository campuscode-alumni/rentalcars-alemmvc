class ConfirmRentalPolicy
  def initialize(user, rental)
    @user = user
    @rental = rental
  end

  def allowed?
    return true if user.admin?
    return true if user.subsidiary == rental.subsidiary
    false
  end

  private 

  attr_reader :user, :rental
end

