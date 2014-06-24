class Entrepreneur < Client
	attr_accessible :linkedRestaurant
	attr_accessor :linkedRestaurant

	has_many :restaurants, dependent: :delete_all

end
