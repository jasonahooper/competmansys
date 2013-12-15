require 'spec_helper'

describe CompetitionAttendee do
  it { should belong_to(:competition) }
  it { should belong_to(:user) }
  it { should have_many(:event_registrations) }
end
