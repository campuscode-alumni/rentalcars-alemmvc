class RemovePlacaFromCar < ActiveRecord::Migration[5.2]
  def change
    remove_column :cars, :placa, :string
  end
end
