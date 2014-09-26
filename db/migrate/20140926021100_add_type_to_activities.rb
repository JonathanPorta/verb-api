class AddTypeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :type, :string
    remove_column :activities, :body
  end
end
