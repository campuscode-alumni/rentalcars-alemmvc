class RemoveCarInsuranteFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :car_insurante, :float
  end
end
