class Mess < ApplicationRecord
  after_create_commit { MessBroadcastJob.perform_later(self) }
  belongs_to :user
  belongs_to :conversation
end
