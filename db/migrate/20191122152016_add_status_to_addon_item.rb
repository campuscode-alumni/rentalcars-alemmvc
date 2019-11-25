class AddStatusToAddonItem < ActiveRecord::Migration[5.2]
  def change
    add_column :addon_items, :status, :integer
  end
end
