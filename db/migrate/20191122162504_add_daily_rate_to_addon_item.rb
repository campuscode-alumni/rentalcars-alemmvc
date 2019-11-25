class AddDailyRateToAddonItem < ActiveRecord::Migration[5.2]
  def change
    add_column :addon_items, :daily_rate, :float
  end
end
