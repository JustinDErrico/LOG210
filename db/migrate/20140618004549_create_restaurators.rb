class CreateRestaurators < ActiveRecord::Migration
  def change
    create_table :restaurators do |t|
      t.timestamps
    end
  end
end
