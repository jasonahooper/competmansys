require 'spec_helper'

describe User do
  it { should have_many(:competitions) }
  it { should have_many(:competition_administrators) }
end
