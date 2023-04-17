class Channel < ApplicationRecord
  belongs_to :admin, class_name: 'User', optional: true
  has_and_belongs_to_many :users
  has_many :received_messages, as: :receiver, class_name: 'Message'
end
