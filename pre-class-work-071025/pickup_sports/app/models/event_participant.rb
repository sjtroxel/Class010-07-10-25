class EventParticipant < ApplicationRecord
  # validations
  # validates :rating, presence: true

  # associations
  belongs_to :user
  belongs_to :event
end
