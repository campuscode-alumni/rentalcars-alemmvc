class CreateRentalPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_prices do |t|
      t.float :daily_rate
      t.references :subsidiary, foreign_key: true
      t.references :category, foreign_key: true
      t.float :daily_car_insurance
      t.float :daily_third_party_insurance

      t.timestamps
    end
  end
end
