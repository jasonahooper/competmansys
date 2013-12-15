require 'spec_helper'

describe User do
  it { should have_many(:competitions) }
  it { should have_many(:competition_administrators) }
  it { should have_many(:competition_attendees) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
