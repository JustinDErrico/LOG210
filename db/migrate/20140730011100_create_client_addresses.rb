class CreateClientAddresses < ActiveRecord::Migration
  def change
    create_table :client_addresses do |t|
      t.string :address
      t.integer :client_id

      t.timestamps
    end
  end
end
