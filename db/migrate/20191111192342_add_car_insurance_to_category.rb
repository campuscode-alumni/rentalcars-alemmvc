class AddCarInsuranceToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :car_insurance, :float
  end
end
