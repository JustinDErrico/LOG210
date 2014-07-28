class Menu < ActiveRecord::Base
  attr_accessible :nom, :restaurant_id, :plats_attributes

  validates :nom, length: { minimum: 2 }


  has_many :plats
  belongs_to :restaurant

  accepts_nested_attributes_for :plats, :allow_destroy => true
end
