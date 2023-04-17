class Chat < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :chats_users
  has_many :messages
  belongs_to :last_message, class_name: 'Message', optional: true
  has_one :channel
end
