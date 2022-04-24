require 'spec_helper'

describe CompetitionAdministrator do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:competition)}
end
