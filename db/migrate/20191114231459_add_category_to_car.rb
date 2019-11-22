class AddCategoryToCar < ActiveRecord::Migration[5.2]
  def change
    add_reference :cars, :category, foreign_key: true
  end
end
