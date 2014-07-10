class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.integer :parent_id
      t.integer :owner_id
      t.string :type
      t.string  :name
      t.string  :trading_name
      t.string  :gov_identification
      t.string  :description
      t.timestamps
    end
  end
end
