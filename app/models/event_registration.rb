class EventRegistration < ActiveRecord::Base
  belongs_to :competition_attendee
  belongs_to :event
end
