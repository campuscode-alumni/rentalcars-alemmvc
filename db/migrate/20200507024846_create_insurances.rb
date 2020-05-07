class CreateInsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :insurances do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.float :daily_rate

      t.timestamps
    end
  end
end
