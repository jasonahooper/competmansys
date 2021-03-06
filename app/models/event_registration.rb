class EventRegistration < ActiveRecord::Base
  validates :event_id, :presence => true

  belongs_to :competition_attendee
  belongs_to :event

  has_one :entry, :through => :competition_attendee, :source => :user

  accepts_nested_attributes_for :entry
end
