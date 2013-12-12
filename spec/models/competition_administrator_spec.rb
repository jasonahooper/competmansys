require 'spec_helper'

describe CompetitionAdministrator do
  it { should belong_to(:user) }
  it { should belong_to(:competition)}
end
