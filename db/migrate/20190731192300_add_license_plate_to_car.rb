class AddLicensePlateToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :license_plate, :string
  end
end
