class RemoveAdressFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_reference :clients, :adress, foreign_key: true
  end
end
