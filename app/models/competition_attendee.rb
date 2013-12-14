class CompetitionAttendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition
end
