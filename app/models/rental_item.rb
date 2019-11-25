class RentalItem < ApplicationRecord
  belongs_to :rental
  belongs_to :rentable, polymorphic: true

  def car?
    rentable.is_a? Car
  end
end
