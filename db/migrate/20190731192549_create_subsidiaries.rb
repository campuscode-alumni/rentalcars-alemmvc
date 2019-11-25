class CreateSubsidiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :subsidiaries do |t|
      t.string :name

      t.timestamps
    end
  end
end
