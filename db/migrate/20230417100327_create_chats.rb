class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.boolean :is_channel
      t.references :last_message, foreign_key: { to_table: :messages }

      t.timestamps
    end
  end
end
