class CreateJoinTableUsersChannels < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :channels do |t|
      t.index :user_id
      t.index :channel_id
      # t.index [:user_id, :channel_id]
      # t.index [:channel_id, :user_id]
    end
  end
end
