class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :gender, :integer, null: false
    add_column :users, :is_admin, :boolean, default: false
  end
end
