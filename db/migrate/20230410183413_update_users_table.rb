class UpdateUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :is_admin, :boolean, null: false, default: false
    add_index :users, :name
  end
end
