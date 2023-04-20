class Chat < ApplicationRecord
  has_many :user_chats, dependent: :destroy
  has_many :users, through: :user_chats

  has_many :messages, dependent: :destroy
  belongs_to :last_message, class_name: 'Message', optional: true

  has_one :channel, touch: true, dependent: :destroy

  scope :channels, -> { where(is_channel: true) }
  scope :private_chats, -> { where(is_channel: false) }

  scope :inboxes, lambda { |current_user|
    private_chats.joins(:users)
                 .where.not(users: { id: current_user })
                 .select('DISTINCT users.name as inbox_name, users.id, chats.*')
  }
end
