class CreateIbeacons < ActiveRecord::Migration
  def change
    create_table :ibeacons do |t|
      t.string :mac_address      
      t.integer :establishment_id
      t.string :description      
      t.timestamps
    end
  end
end
