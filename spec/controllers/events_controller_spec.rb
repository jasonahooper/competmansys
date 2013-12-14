require 'spec_helper'

describe EventsController do
  before do
    Competition.any_instance.stub(:geocode).and_return([1,1])

    @user = User.create!(:email => 'test@example.com', :password => 'password')

    file = fixture_file_upload('/sheffield.jpg','application/jpg')

    @competition = Competition.create!(
      :name => 'Test', :description => 'Test competition',
      :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
      :image => file, :registration_close_date => 2.days.from_now,
      :user_id => @user.id, :location => 'a test location')
  end

  context 'with an existing event' do
    before do
      @event = Event.create!(:name => 'Test', :description => 'Test',
        :competition => @competition)
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

  describe 'creating a new event' do
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
