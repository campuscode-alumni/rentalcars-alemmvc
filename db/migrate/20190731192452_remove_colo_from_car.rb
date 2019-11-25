class RemoveColoFromCar < ActiveRecord::Migration[5.2]
  def change
    remove_column :cars, :colo, :string
  end
end
