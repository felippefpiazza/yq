class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :user_id
      t.string :device_signature
      t.boolean :revoked
      t.datetime :expires_at
      t.timestamps
    end
  end
end
