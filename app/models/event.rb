class Event < ApplicationRecord
  belongs_to :host,
             class_name: "User",
             inverse_of: :hosted_events,
             foreign_key: :host_id

  has_many :sign_ups
  has_many :attendees, through: :sign_ups

  validates :name, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :location, presence: true
end
