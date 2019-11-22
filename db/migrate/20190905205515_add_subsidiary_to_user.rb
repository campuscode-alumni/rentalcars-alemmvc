class AddSubsidiaryToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :subsidiary, foreign_key: true
  end
end
