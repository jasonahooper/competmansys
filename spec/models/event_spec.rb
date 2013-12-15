require 'spec_helper'

describe Event do
  it { should belong_to(:competition) }
  it { should have_many(:event_registrations) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
