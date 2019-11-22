class RemoveCategoryFromCar < ActiveRecord::Migration[5.2]
  def change
    remove_reference :cars, :category, foreign_key: true
  end
end
