class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :birthday
      t.string :facebook_token
      t.datetime :facebook_token_expires_at

      t.timestamps
    end

    add_index :users, :facebook_id, unique: true
  end
end
