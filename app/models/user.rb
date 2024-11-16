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
end
