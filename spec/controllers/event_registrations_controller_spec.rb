require 'spec_helper'

describe EventRegistrationsController do

  before do
    Competition.any_instance.stub(:geocode)
    User.any_instance.stub(:geocode)

    @user = User.create!(:email => 'test@example.com', :password => 'password')

    file = fixture_file_upload('/sheffield.jpg','application/jpg')

    @competition = Competition.create!(
      :name => 'Test', :description => 'Test competition',
      :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
      :image => file, :registration_close_date => 2.days.from_now,
      :user_id => @user.id, :location => 'a test location')

    @competition_attendee = CompetitionAttendee.create!(
      :competition_id => @competition.id, :user_id => @user.id)

    @event = Event.create!(
      :competition_id => @competition.id, :name => 'Test Event',
        :description => 'Test Event Desc')

    sign_in @user

  end

  describe 'a user registers for an event' do
    before do
      post :create, :competition_id => @competition.id,
        :competition_attendee_id => @competition_attendee.id,
        :event_registration => { :event_id => @event.id}
    end

    it 'should create the EventRegistration' do
      expect(EventRegistration.count).to eq(1)
    end

    it 'should set the competition_attendee_id' do
      expect(assigns(:registration).competition_attendee_id).to eq(
        @competition_attendee.id)
    end

    it 'should set the event_id' do
      expect(assigns(:registration).event_id).to eq(@event.id)
    end

    it 'should redirect to the list event page' do
      expect(response).to redirect_to(competition_events_path(@competition.id))
    end

  end

  describe 'a user withdraws from an event' do
    before do
      @event_registration = EventRegistration.create!(
        :competition_attendee_id => @competition_attendee.id,
        :event_id => @event.id)
      delete :destroy, :competition_id => @competition.id,
        :competition_attendee_id => @competition_attendee.id,
        :id => @event_registration.id
    end

    it 'should delete the EventRegistration' do
      expect(EventRegistration.count).to eq(0)
    end

    it 'should redirect to the list event page' do
      expect(response).to redirect_to(competition_events_path(@competition.id))
    end

  end

end
