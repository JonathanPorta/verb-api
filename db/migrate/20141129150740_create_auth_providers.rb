class CreateAuthProviders < ActiveRecord::Migration
  def change
    create_table :auth_providers do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :token
      t.string :secret
      t.datetime :token_expiration
      t.datetime :last_used

      t.timestamps
    end
  end
end
