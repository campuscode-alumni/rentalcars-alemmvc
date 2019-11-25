class RemoveCategoryFromCarModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :car_models, :category, :string
  end
end
