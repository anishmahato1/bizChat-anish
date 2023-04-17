class Channel < ApplicationRecord
    belongs_to :chat
    belongs_to :admin, class_name: 'User', optional: true
  end
  