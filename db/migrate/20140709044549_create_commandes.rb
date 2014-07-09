class CreateCommandes < ActiveRecord::Migration
  def change
    create_table :commandes do |t|
      t.integer :client_id
      t.integer :restaurant_id
      t.datetime :deliveryTime
      t.string :deliveryAddress
      t.timestamps
    end
  end
end
