require 'spec_helper'

describe Competition do

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:competition_administrators) }
  it { is_expected.to have_many(:competition_attendees) }
  it { is_expected.to have_many(:events) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_presence_of(:registration_close_date) }
  it { is_expected.to validate_presence_of(:location) }

  it 'should have start_date after today' do
    expect(Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.yesterday,
      :end_date => Date.yesterday)).to have(1).errors_on(:start_date)
  end

  it 'should have end_date on or after start_date' do
    expect(Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.today + 1.day,
      :end_date => Date.yesterday)).to have(1).errors_on(:end_date)
  end

  it 'should have registration_close_date on or before start_date' do
    expect(Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.today,
      :registration_close_date => Date.today + 1.day)).to have(1).
        errors_on(:registration_close_date)
  end

  it { is_expected.to accept_nested_attributes_for(:events) }

  it 'should return upcoming competitions starting after today' do
    Competition.make!(:start_date => Date.today, :registration_close_date => Date.today)
    Competition.make!(:start_date => Date.tomorrow, :registration_close_date => Date.today)
    expect(Competition.upcoming.count).to eq(1)
    expect(Competition.after(Date.yesterday).count).to eq(2)
    expect(Competition.between(Date.today,Date.tomorrow).count).to eq(2)
  end

end
