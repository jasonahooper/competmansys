require 'spec_helper'

describe EventRegistration do
  it { should belong_to(:competition_attendee) }
  it { should belong_to(:event) }
end
