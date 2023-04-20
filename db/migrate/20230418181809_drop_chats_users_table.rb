class DropChatsUsersTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :chats_users
  end
end
