require 'spec_helper'

describe Competition do

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  it 'should have start_date after today' do
    Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.yesterday,
      :end_date => Date.yesterday).should have(1).errors_on(:start_date)
  end

  it 'should have end_date on or after start_date' do
    Competition.new(:name => 'test',:description => 'test',
      :image => 'test', :start_date => Date.today,
      :end_date => Date.yesterday).should have(1).errors_on(:end_date)
  end
end
