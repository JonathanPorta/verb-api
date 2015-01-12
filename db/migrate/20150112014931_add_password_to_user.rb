class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    add_index :users, :email, unique: true
  end
end
