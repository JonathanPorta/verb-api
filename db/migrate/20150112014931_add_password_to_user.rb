class AddPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
    add_index :users, :email, unique: true
  end
end
