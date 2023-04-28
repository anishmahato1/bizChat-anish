class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.boolean :is_channel
      t.integer :last_message_id

      t.timestamps
    end
  end
end
