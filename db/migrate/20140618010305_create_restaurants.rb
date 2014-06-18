class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.belongs_to :entrepreneur
      t.belongs_to :restaurator
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
