class AddReservationCodeToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :reservation_code, :string
  end
end
