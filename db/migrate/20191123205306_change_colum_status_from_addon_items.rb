class ChangeColumStatusFromAddonItems < ActiveRecord::Migration[5.2]
  def change
    change_column_default :addon_items, :status, 0
  end
end
