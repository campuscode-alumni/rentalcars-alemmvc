class AddRentableToRentalItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :rental_items, :rentable, polymorphic: true
  end
end
