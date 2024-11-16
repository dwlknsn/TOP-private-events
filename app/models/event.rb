class Event < ApplicationRecord
  belongs_to :host,
             class_name: "User",
             inverse_of: :hosted_events,
             foreign_key: :host_id

  has_many :sign_ups, dependent: :destroy
  has_many :attendees, through: :sign_ups

  validates :name, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :location, presence: true

  scope :hosted_by, ->(user) { where(host_id: user.id) }
  scope :not_hosted_by, ->(user) { where.not(host_id: user.id) }
  scope :attended_by, ->(user) { joins(:sign_ups).where(sign_ups: { attendee_id: user.id }) }
  scope :not_attended_by, ->(user) { where.not(id: attended_by(user)) }
  scope :attendable_by, ->(user) { not_attended_by(user).not_hosted_by(user) }

  def owned_by?(user)
    host_id == user.id
  end

  def attended_by?(user)
    sign_ups.exists?(attendee_id: user.id)
  end

  def attendable_by?(user)
    !attended_by?(user) && !owned_by?(user)
  end
end
