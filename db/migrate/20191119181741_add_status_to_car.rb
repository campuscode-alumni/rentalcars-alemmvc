class AddStatusToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :status, :integer, default: 0
  end
end
