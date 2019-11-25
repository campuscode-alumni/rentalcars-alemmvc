class AddDailyRateToRentalItem < ActiveRecord::Migration[5.2]
  def change
    add_column :rental_items, :daily_rate, :float
  end
end
