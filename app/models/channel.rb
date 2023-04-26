class Channel < ApplicationRecord
  belongs_to :chat, dependent: :destroy
  belongs_to :admin, class_name: 'User', optional: true, validate: true

  validates :name, presence: true, length: { in: 3..20 }, uniqueness: true
  validates :description, length: { maximum: 100 }, if: -> { description.present? }

  # scope :channel_with_users, -> {includes(chat:)}
end
