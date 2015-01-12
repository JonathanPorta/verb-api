class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :api_token, :string

    add_index :users, :email, unique: true
    add_index :users, :api_token, unique: true
  end
end
