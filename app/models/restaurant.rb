class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :linkedRestaurator, :linkedEntrepreneur
  attr_accessor :linkedRestaurator, :linkedEntrepreneur

  belongs_to :restaurator
  belongs_to :entrepreneur
end
