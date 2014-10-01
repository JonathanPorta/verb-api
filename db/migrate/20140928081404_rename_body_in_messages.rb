class RenameBodyInMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :body
    add_column :messages, :verb, :string
  end
end
