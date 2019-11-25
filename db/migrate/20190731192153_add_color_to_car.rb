class AddColorToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :colo, :string
  end
end
