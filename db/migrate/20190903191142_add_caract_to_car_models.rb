class AddCaractToCarModels < ActiveRecord::Migration[5.2]
  def change
    add_column :car_models, :motorization, :string
    add_column :car_models, :fuel_type, :string
    add_column :car_models, :category, :string
  end
end
