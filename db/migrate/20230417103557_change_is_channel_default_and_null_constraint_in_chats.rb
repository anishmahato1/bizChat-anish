class ChangeIsChannelDefaultAndNullConstraintInChats < ActiveRecord::Migration[7.0]
  def change
    change_column_default :chats, :is_channel, false
    change_column_null :chats, :is_channel, false
  end
end
