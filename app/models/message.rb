class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :chat

  after_create_commit :update_chat_last_message


  def update_chat_last_message
    chat.update(last_message: self)
  end
end
