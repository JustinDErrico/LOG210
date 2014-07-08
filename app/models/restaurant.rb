class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :linkedRestaurator, :linkedEntrepreneur
  attr_accessor :linkedRestaurator, :linkedEntrepreneur

  has_many :menus
  belongs_to :restaurator
  belongs_to :entrepreneur
end
