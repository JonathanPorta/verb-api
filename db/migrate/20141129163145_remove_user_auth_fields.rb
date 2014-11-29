class RemoveUserAuthFields < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_id
    remove_column :users, :facebook_token
    remove_column :users, :facebook_token_expires_at
  end

  remove_index :users, :facebook_id

  add_index :auth_providers, :uid
  add_index :auth_providers, :provider
end
