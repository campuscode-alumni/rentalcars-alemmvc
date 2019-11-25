class AddFieldColorToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :color, :string
  end
end
