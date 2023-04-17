class Chat < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages
  belongs_to :last_message, class_name: 'Message', optional: true
  has_one :channel, optional: true
end
