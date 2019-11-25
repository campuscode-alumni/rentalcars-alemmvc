class AddDailyRateToAddon < ActiveRecord::Migration[5.2]
  def change
    add_column :addons, :daily_rate, :float
  end
end
