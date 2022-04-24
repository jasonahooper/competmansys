require 'spec_helper'

describe CompetitionAttendee do
  it { is_expected.to belong_to(:competition) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:event_registrations) }
end
