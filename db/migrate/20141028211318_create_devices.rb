class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end

    add_index :devices, :token, unique: true
  end
end
