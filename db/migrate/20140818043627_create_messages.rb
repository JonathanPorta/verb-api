class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.datetime :acknowledged_at
      t.text :body

      t.timestamps
    end
  end
end
