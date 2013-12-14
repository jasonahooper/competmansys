require 'spec_helper'

describe CompetitionAttendeesController do
  before do
    Competition.any_instance.stub(:geocode).and_return([1,1])

    @user = User.create!(:email => 'test@example.com', :password => 'password')

    file = fixture_file_upload('/sheffield.jpg','application/jpg')

    @competition = Competition.create!(
      :name => 'Test', :description => 'Test competition',
      :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
      :image => file, :registration_close_date => 2.days.from_now,
      :user_id => @user.id, :location => 'a test location')

    sign_in @user

  end

  describe 'a user indicates they will attend a competition' do
    before do
      post :create, :competition_id => @competition.id,
        :competition_attendee => { :user_id => @user.id,
        :competition_id => @competition.id}
    end

    it 'should create the CompetitionAttendee' do
      expect(CompetitionAttendee.count).to eq(1)
    end

    it 'should set the user_id' do
      expect(assigns(:attendee).user_id).to eq(@user.id)
    end

    it 'should set the competition_id' do
      expect(assigns(:attendee).competition_id).to eq(@competition.id)
    end

  end
end
