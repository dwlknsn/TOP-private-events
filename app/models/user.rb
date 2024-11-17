class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Where the user is a Host
  has_many :hosted_events,
           class_name: "Event",
           inverse_of: :host

  # Where the user is an Attendee
  has_many :sign_ups, inverse_of: :attendee
  has_many :attended_events,
           through: :sign_ups,
           source: :event,
           class_name: "Event"

  # Where the user is an Invitee
  has_many :invitations, inverse_of: :invitee
  has_many :invited_events,
           through: :invitations,
           source: :event,
           class_name: "Event"

  scope :attending, ->(event) { joins(:sign_ups).where(sign_ups: { event_id: event.id }) }
  scope :invited_to, ->(event) { joins(:invitations).where(invitations: { event_id: event.id }) }
  scope :hosting, ->(event) { where(id: event.host_id) }
  scope :inviteable_to, ->(event) { where.not(id: attending(event))
                                    .where.not(id: invited_to(event))
                                    .where.not(id: hosting(event)) }
end
