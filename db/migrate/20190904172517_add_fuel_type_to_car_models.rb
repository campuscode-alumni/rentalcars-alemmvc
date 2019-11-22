class AddFuelTypeToCarModels < ActiveRecord::Migration[5.2]
  def change
    add_reference :car_models, :fuel_type, foreign_key: true
  end
end
