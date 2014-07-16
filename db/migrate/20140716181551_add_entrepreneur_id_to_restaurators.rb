class AddEntrepreneurIdToRestaurators < ActiveRecord::Migration
  def change
    add_column :restaurators, :entrepreneur_id, :integer
  end
end
