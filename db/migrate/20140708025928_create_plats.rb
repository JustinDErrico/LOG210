class CreatePlats < ActiveRecord::Migration
  def change
    create_table :plats do |t|
      t.integer :menu_id
      t.string :nom
      t.string :description
      t.float :prix

      t.timestamps
    end
  end
end
