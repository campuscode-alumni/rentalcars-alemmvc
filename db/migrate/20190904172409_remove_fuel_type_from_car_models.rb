class RemoveFuelTypeFromCarModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :car_models, :fuel_type, :string
  end
end
