require 'spec_helper'

describe EventRegistrationsController do

  before do
    @user = User.make!(:competition_owner)
    @competition = Competition.make!(:user_id => @user.id)
    @competition_attendee = CompetitionAttendee.make!(
      :competition_id => @competition.id, :user_id => @user.id)
    @event = Event.make!(:competition_id => @competition.id)
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

    it 'should redirect to the competition show page' do
      expect(response).to redirect_to(competition_path(@competition.id))
    end
  end

  describe 'a user withdraws from an event' do
    before do
      @event_registration = EventRegistration.make!(
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
      expect(response).to redirect_to(competition_path(@competition.id))
    end
  end

  describe 'results are updated for an event registration' do
    before do
      @event_registration = EventRegistration.make!(
        :competition_attendee_id => @competition_attendee.id,
        :event_id => @event.id)

      patch :update, :competition_id => @competition.id,
        :competition_attendee_id => @competition_attendee.id,
        :id => @event_registration.id, :event_registration => {
          :result => '1:23:31', :position => 1 }
    end
    it 'should update the event results' do
      expect(assigns(:event_registration).result).to eq('1:23:31')
      expect(assigns(:event_registration).position).to eq(1)
    end
  end

  describe 'results are edited for an event registration' do
    before do
      @event_registration = EventRegistration.make!(
        :competition_attendee_id => @competition_attendee.id,
        :event_id => @event.id)
      get :edit, :competition_id => @competition.id,
        :competition_attendee_id => @competition_attendee.id,
        :id => @event_registration.id
    end
    it 'should render the edit page' do
      expect(response).to render_template("edit")
    end
  end
end
