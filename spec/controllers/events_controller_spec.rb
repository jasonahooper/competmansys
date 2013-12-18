require 'spec_helper'

describe EventsController do
  before do
    @user = User.make!
    sign_in @user
    @competition = Competition.make!(:user_id => @user.id)
  end

  context 'with an existing event' do
    before do
      @event = Event.make!(:competition_id => @competition.id)
    end

    describe 'listing events' do
      before do
        get :index, :competition_id => @competition.id
      end

      it 'should give a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should render the list event page' do
        expect(response).to render_template("index")
      end
    end

    describe 'deleting events' do
      before do
        delete :destroy, :competition_id => @competition.id, :id => @event.id
      end

      it 'should redirect to the list event page' do
        expect(response).to redirect_to(competition_events_path)
      end

      it 'should delete the event' do
        expect(Event.count).to eq(0)
      end
    end

    describe 'saving events' do
      before do
        patch :update, :competition_id => @competition.id, :id => @event.id,
          :event => { :name => 'updated'}
      end

      it 'should redirect to the list event page' do
        expect(response).to redirect_to(competition_events_path)
      end

      it 'should update the event' do
        expect(assigns(:event).name).to eq('updated')
      end

    end

    describe 'a list of entrants for an event' do
      before do
        @attendee = CompetitionAttendee.make!(:competition_id => @competition.id)
        @entry = EventRegistration.make!(:competition_attendee_id => @attendee.id,
          :event_id => @event.id)
        get :entrants, :competition_id => @competition.id, :event_id => @event.id
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'should get a list of the entrants' do
        expect(assigns(:entrants).count).to eq(1)
      end

      it 'should render the entrants page' do
        expect(response).to render_template("entrants")
      end
    end

    describe 'results are edited for a whole event' do
      before do
        @entrants = []
        5.times do
          @entrants << CompetitionAttendee.make!(:competition_id => @competition.id)
        end
        @entrants.each_with_index do |entrant, i|
          er = EventRegistration.make(
            :competition_attendee_id => entrant.id, :event_id => @event.id)
          er.position = 5-i
          er.save!
        end
        get :edit_results, :competition_id => @competition.id, :event_id => @event.id
      end
      it 'should allow editing of the event results' do
        expect(assigns(:event).event_registrations.count).to eq(5)
      end
    end

    describe 'results are shown for a whole event' do
      before do
        @entrants = []
        5.times do
          @entrants << CompetitionAttendee.make!(:competition_id => @competition.id)
        end
        @entrants.each_with_index do |entrant, i|
          er = EventRegistration.make(
            :competition_attendee_id => entrant.id, :event_id => @event.id)
          er.position = 5-i
          er.save!
        end
        get :show_results, :competition_id => @competition.id, :event_id => @event.id
      end

      it 'should get all results' do
        expect(assigns(:event).event_registrations.count).to eq(5)
      end

      it 'should get give status 200' do
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'creating a new event' do
    before do
      get :new, :competition_id => @competition.id
    end

    it 'should give a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'should render the new Event page' do
      expect(response).to render_template("new")
    end

  end

  describe 'saving a new event' do
    before do
      post :create, :competition_id => @competition.id, :event => {
        :name => 'test new event', :description => 'test new event'}
    end

    it 'should create the Event' do
      expect(Event.count).to eq(1)
    end

    it 'should set the competition_id' do
      expect(assigns(:event).competition_id).to eq(@competition.id)
    end

    it 'should redirect to the list event page' do
      expect(response).to redirect_to(competition_events_path)
    end
  end

end
