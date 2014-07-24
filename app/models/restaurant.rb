class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :linkedRestaurator, :linkedEntrepreneur
  attr_accessor :linkedRestaurator, :linkedEntrepreneur

  #Validation des champs du formulaire
  validates :name, length: { minimum: 2 }
  validates :address, length: { minimum: 2 }
  #Fin validation du formulaire

  has_many :menus
  belongs_to :restaurator
  belongs_to :entrepreneur
end
