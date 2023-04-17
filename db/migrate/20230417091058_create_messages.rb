class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content, limit: 100
      t.references :sender, foreign_key: { to_table: :users }
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
