class CompetitionAttendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition
  has_many :event_registrations, :dependent => :destroy
end
