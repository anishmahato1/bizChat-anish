class Message < ApplicationRecord
  belongs_to :receiver, polymorphic: true
  beongs_to :sender, class_name: 'User'
end
