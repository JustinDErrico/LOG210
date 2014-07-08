class Plat < ActiveRecord::Base
  attr_accessible :description, :menu_id, :nom, :prix

  belongs_to :menu
end
