class SignUp < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: "User", foreign_key: :attendee_id

  validate :cannot_attend_own_event
  validate :cannot_attend_same_event_twice

  private

  def cannot_attend_own_event
    return unless attendee_id == event.host_id
    errors.add(:attendee_id, "cannot attend own event")
  end

  def cannot_attend_same_event_twice
    return unless SignUp.where(attendee_id: attendee_id, event_id: event_id).exists?
    errors.add(:attendee_id, "cannot attend same event twice")
  end
end
