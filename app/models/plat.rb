class Plat < ActiveRecord::Base
  attr_accessible :description, :menu_id, :nom, :prix

  validates :nom, length: { minimum: 2 }
  validates_numericality_of :prix

  belongs_to :menu
end
