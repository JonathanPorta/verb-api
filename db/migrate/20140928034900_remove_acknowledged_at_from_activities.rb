class RemoveAcknowledgedAtFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :acknowledged_at
  end
end
