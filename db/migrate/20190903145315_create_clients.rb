class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :cnpj
      t.string :cpf
      t.string :email
      t.references :adress, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
