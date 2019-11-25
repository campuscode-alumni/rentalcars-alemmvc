class AddPriceProjectionToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :price_projection, :float
  end
end
