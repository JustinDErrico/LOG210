class Commande < ActiveRecord::Base
  attr_accessible :client_id, :restaurant_id, :deliveryTime, :deliveryAddress
end
