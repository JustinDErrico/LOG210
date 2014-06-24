class Restaurator < Client
	attr_accessible :linkedRestaurant
	attr_accessor :linkedRestaurant

	has_many :restaurants

end
