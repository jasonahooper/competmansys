class Event < ActiveRecord::Base
  validates :name, :presence => :true
  validates :description, :presence => true

  belongs_to :competition
  has_many :event_registrations
  has_many :registrants, :through => :event_registrations, :source => :competition_attendee
  has_many :entries, :through => :registrants, :source => :user
end
