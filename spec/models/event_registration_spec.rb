require 'spec_helper'

describe EventRegistration do
  it { should belong_to(:competition_attendee) }
  it { should belong_to(:event) }
  it { should validate_presence_of(:event_id) }
end
