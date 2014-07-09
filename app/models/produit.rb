class Produit < ActiveRecord::Base
  attr_accessible :commande_id, :plat_id, :quantity
end
