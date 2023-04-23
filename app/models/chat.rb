class Chat < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  has_many :user_chats, dependent: :destroy
  has_many :users, through: :user_chats

  has_many :messages, dependent: :destroy
  belongs_to :last_message, class_name: 'Message', optional: true

  has_one :channel, touch: true, dependent: :destroy

  scope :channels, -> { where(is_channel: true) }
  scope :private_chats, -> { where(is_channel: false) }

  def self.messages_with_sender_avatar_included(chat)
    chat.messages.includes(sender: {avatar_attachment: :blob}).find_each
  end
    
end
