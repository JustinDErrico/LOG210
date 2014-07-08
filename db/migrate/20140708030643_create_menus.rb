class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :restaurant_id
      t.string :nom

      t.timestamps
    end
  end
end
