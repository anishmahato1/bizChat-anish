class ChangeNullConstraintInMessages < ActiveRecord::Migration[7.0]
  def change
    change_column_null :messages, :sender_id, false
    change_column_null :messages, :chat_id, false
  end
end
