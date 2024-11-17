class Event < ApplicationRecord
  belongs_to :host,
             class_name: "User",
             inverse_of: :hosted_events,
             foreign_key: :host_id

  has_many :sign_ups, dependent: :destroy
  has_many :attendees, through: :sign_ups

  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations

  validates :name, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :location, presence: true

  scope :default_order, ->() { order(datetime: :asc) }
  scope :hosted_by, ->(user) { where(host_id: user.id).default_order }
  scope :not_hosted_by, ->(user) { where.not(host_id: user.id).default_order }
  scope :attended_by, ->(user) { joins(:sign_ups).where(sign_ups: { attendee_id: user.id }).default_order }
  scope :not_attended_by, ->(user) { where.not(id: attended_by(user)).default_order }
  scope :attendable_by, ->(user) { upcoming.not_attended_by(user).not_hosted_by(user) }
  scope :past, ->() { where("datetime < ?", Time.now).order(datetime: :desc) }
  scope :upcoming, ->() { where("datetime > ?", Time.now).default_order }
  scope :after, ->(date) { where("datetime > ?", date).default_order }
  scope :on, ->(date) { where(datetime: date.to_date.beginning_of_day..date.to_date.end_of_day).default_order }

  def hosted_by?(user)
    host_id == user.id
  end

  def attended_by?(user)
    sign_ups.exists?(attendee_id: user.id)
  end

  def attendable_by?(user)
    !attended_by?(user) && !hosted_by?(user)
  end
end
