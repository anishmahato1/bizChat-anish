class Message < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :sender, class_name: 'User'
  belongs_to :chat, touch: true

  has_one_attached :image

  scope :with_avatar_attached_of_sender, -> { includes(sender: { avatar_attachment: :blob }) }
end
