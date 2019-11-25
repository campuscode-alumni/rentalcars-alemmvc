class RemoveSubsidiaryFromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_reference :addresses, :subsidiary, foreign_key: true
  end
end
