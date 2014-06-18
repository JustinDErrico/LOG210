class CreateClients < ActiveRecord::Migration
  def change
    drop_table :clients
    create_table :clients do |t|
      t.string :address
      t.date :dateOfBirth
      t.string :emailAddress
      t.string :name
      t.string :password
      t.string :phoneNumber
      t.string :clientType
      t.string :zipCode
      
      t.timestamps
    end
  end
end
