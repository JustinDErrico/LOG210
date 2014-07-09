class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.integer :commande_id
      t.integer :plat_id
      t.integer :quantity

      t.timestamps
    end
  end
end
