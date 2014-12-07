class ActionableRelations < ActiveRecord::Migration
  def change
    remove_column :activities, :message_id, :integer
    add_column :activities, :actionable_id, :integer
    add_column :activities, :actionable_type, :string
  end
end
