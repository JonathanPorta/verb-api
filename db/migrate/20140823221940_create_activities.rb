class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :message_id
      t.datetime :acknowledged_at
      t.text :body

      t.timestamps
    end
  end
end
