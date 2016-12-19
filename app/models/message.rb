class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later(self) }

  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
end
