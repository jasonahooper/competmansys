require 'spec_helper'

describe Competition do

  it { should belong_to(:user) }

  it { should have_many(:competition_administrators) }
  it { should have_many(:competition_attendees) }
  it { should have_many(:events) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:registration_close_date) }
  it { should validate_presence_of(:location) }

  it 'should have start_date after today' do
    Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.yesterday,
      :end_date => Date.yesterday).should have(1).errors_on(:start_date)
  end

  it 'should have end_date on or after start_date' do
    Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.today + 1.day,
      :end_date => Date.yesterday).should have(1).errors_on(:end_date)
  end

  it 'should have registration_close_date on or before start_date' do
    Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.today,
      :registration_close_date => Date.today + 1.day).should have(1).
        errors_on(:registration_close_date)
  end

  it { should accept_nested_attributes_for(:events) }
end
