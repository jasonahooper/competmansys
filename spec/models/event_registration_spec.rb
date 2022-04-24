require 'spec_helper'

describe EventRegistration do
  it { is_expected.to belong_to(:competition_attendee) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to validate_presence_of(:event_id) }
end
