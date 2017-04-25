class Message < ApplicationRecord

  scope :after_messages, ->message_id do
    where("id > ?", message_id) if Message.find_by(id: message_id) || message_id == 0
  end
end
