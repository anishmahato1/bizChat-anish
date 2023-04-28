class Message < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :sender, class_name: 'User'
  belongs_to :chat, touch: true

  has_one_attached :image, dependent: :destroy do |image|
    image.variant :medium, resize_to_limit: [200, 200]
  end

  validates :content, presence: true, unless: -> { image.attached? }
  validate :attachment_must_be_image_type, if: -> { image.attached? }

  after_create_commit :update_last_message_in_chat

  after_create_commit lambda {
                        broadcast_prepend_to [chat, 'messages'],
                                             partial: 'messages/message_box',
                                             locals: { message: self }, target: 'chats-show'
                      }

  scope :with_avatar_attached_of_sender, -> { includes(sender: { avatar_attachment: :blob }) }

  private

  def update_last_message_in_chat
    chat.update(last_message_id: id)
  end

  def attachment_must_be_image_type
    return if image.content_type.in?(%w[image/jpeg image/png image/gif])

    errors.add(:image, 'must be a JPEG, PNG, GIF')
  end
end
