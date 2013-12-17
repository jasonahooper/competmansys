class EventRegistration < ActiveRecord::Base
  belongs_to :competition_attendee
  belongs_to :event
  has_one :entry, :through => :competition_attendee, :source => :user
end
