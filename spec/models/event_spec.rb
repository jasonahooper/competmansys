require 'spec_helper'

describe Event do
  it { is_expected.to belong_to(:competition) }
  it { is_expected.to have_many(:event_registrations) }

  it { is_expected.to validate_presence_of(:name) }
end
