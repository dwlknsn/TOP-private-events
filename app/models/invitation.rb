class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User", foreign_key: :invitee_id

  validates :expires_at, presence: true
  validate :cannot_expire_before_now
  validate :cannot_expire_after_event_begins
  validate :cannot_invite_to_past_event
  validate :cannot_invite_host_to_own_event
  validate :cannot_accept_expired_invitation
  validate :cannot_decline_expired_invitation
  validate :cannot_have_multiple_open_invitations_to_same_event

  scope :open, ->() { where(accepted_at: nil, declined_at: nil).where.not(id: expired) }
  scope :accepted, -> { where.not(accepted_at: nil).where.not(id: declined) }
  scope :declined, -> { where.not(declined_at: nil) }
  scope :expired, -> { where(expires_at: ...Time.now) }

  def accept!
    transaction do
      touch(:accepted_at)
      event.sign_ups.create!(attendee: invitee)
    end
  end

  def decline!
    transaction do
      touch(:declined_at)
      event.sign_ups.find_by(attendee: invitee)&.destroy!
    end
  end

  def expired?
    expires_at < Time.now
  end

  private

  def cannot_expire_before_now
    return unless expired?
    errors.add(:expires_at, "cannot expire before now")
  end

  def cannot_expire_after_event_begins
    return unless expires_at > event.datetime
    errors.add(:expires_at, "invitation must expire before associated event's start time")
  end

  def cannot_invite_to_past_event
    return unless Time.now > event.datetime
    errors.add(:expires_at, "cannot invite to past event")
  end

  def cannot_invite_host_to_own_event
    return unless invitee_id == event.host_id
    errors.add(:invitee_id, "cannot invite host to their own event")
  end

  def cannot_accept_expired_invitation
    return unless accepted_at_changed? && expired?
    errors.add(:accepted_at, "cannot accept an expired invitation")
  end

  def cannot_decline_expired_invitation
    return unless declined_at_changed? && expired?
    errors.add(:declined_at, "cannot decline an expired invitation")
  end

  def cannot_have_multiple_open_invitations_to_same_event
    return unless Invitation.where(invitee_id: invitee_id, event_id: event_id).open.exists?
    errors.add(:invitee_id, "cannot have multiple open invitations to same event")
  end
end
