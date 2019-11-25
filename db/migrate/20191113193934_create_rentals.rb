class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.date :start_date
      t.date :end_date
      t.references :client, foreign_key: true
      t.references :category, foreign_key: true
      t.references :subsidiary, foreign_key: true
      t.integer :status
      t.references :rental_price, foreign_key: true

      t.timestamps
    end
  end
end
