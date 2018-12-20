class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :address
      t.integer :investigation_id

      t.timestamps
    end
    add_index :locations, :address
    add_index :locations, :investigation_id
  end
end
