class Channel < ApplicationRecord
  belongs_to :chat, -> { where is_channel: true }
  belongs_to :admin, class_name: 'User', optional: true

  scope :with_chat_info_ordered, -> { includes(:chat).order(updated_at: :desc) }
end
