class RemoveCarModelFromFuelTypes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :fuel_types, :car_model, foreign_key: true
  end
end
