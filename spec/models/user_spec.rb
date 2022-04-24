require 'spec_helper'

describe User do
  it { is_expected.to have_many(:competitions) }
  it { is_expected.to have_many(:competition_administrators) }
  it { is_expected.to have_many(:competition_attendees) }
  it { is_expected.to have_many(:attending).through(:competition_attendees)}
  it { is_expected.to have_many(:registrations).through(:competition_attendees)}
  it { is_expected.to have_many(:entered).through(:registrations)}
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it "returns first_name and last_name as full_name" do
    user = User.make!
    expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
  end
end
