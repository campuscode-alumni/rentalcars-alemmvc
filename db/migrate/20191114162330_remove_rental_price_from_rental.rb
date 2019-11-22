class RemoveRentalPriceFromRental < ActiveRecord::Migration[5.2]
  def change
    remove_reference :rentals, :rental_price, foreign_key: true
  end
end
