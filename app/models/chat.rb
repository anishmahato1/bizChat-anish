class Chat < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  has_many :user_chats, dependent: :destroy
  has_many :users, through: :user_chats

  has_many :messages, dependent: :destroy
  belongs_to :last_message, class_name: 'Message', optional: true

  has_one :channel, touch: true, dependent: :destroy

  scope :channels, -> { where(is_channel: true) }
  scope :private_chats, -> { where(is_channel: false) }
  scope :filter_current_user, ->(current_user) { where.not(users: { id: current_user }) }

  # after_update_commit broadcast_prepend_later_to

  def self.messages_with_image_and_sender_avatar_included(chat)
    chat.messages.with_attached_image.includes(sender: { avatar_attachment: :blob })
  end

  # method to check if private chat exists between users
  def self.private_chat_between(current_user, user)
    return if current_user == user

    current_user.chats.private_chats.joins(:users).where(users: { id: user })
  end
end
