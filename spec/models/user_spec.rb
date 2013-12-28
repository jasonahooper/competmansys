require 'spec_helper'

describe User do
  it { should have_many(:competitions) }
  it { should have_many(:competition_administrators) }
  it { should have_many(:competition_attendees) }
  it { should have_many(:attending).through(:competition_attendees)}
  it { should have_many(:registrations).through(:competition_attendees)}
  it { should have_many(:entered).through(:registrations)}
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it "returns first_name and last_name as full_name" do
    user = User.make!
    user.full_name.should == user.first_name + ' ' + user.last_name
  end
end
