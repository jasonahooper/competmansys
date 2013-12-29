require 'spec_helper'

describe CompetitionsController do
  before do
    Competition.any_instance.stubs(:geocode)
    @user = User.make!(:competition_owner)
    sign_in @user
  end

  context 'with an existing competition' do
    before do
      @competition = Competition.make!(:user_id => @user.id)
    end

    describe 'finding a competition' do
      before do
        get :find
      end

      it 'should give a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should render the find Competition page' do
        expect(response).to render_template("find")
      end
    end

    describe 'showing a competition' do
      before do
        get :show, { :id => @competition.id }
      end

      it 'should give a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should render the show Competition page' do
        expect(response).to render_template("show")
      end
    end

    describe 'listing competitions' do
      before do
        get :index
      end

      it 'should give a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should render the list Competition page' do
        expect(response).to render_template("index")
      end
    end

    describe 'searching for competitions by keyword' do
      before do
        post :search, :keywords => 'competition'
      end

      it 'should give a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should render the list Competition page' do
        expect(response).to render_template("index")
      end

      it 'should find one competition' do
        expect(assigns(:comps).length).to eq(1)
      end
    end

    describe 'searching for competitions by location' do
      context 'near my home address' do
        before do
          sign_in @user
          post :search, :from => 'my home address', :distance => '50'
        end

        it 'should give a 200 status code' do
          expect(response.status).to eq(200)
        end

        it 'should render the list Competition page' do
          expect(response).to render_template("index")
        end

        it 'should find one competition' do
          expect(assigns(:comps).length).to eq(1)
        end
      end
      context 'near where I am now' do
        before do
          @competition.latitude = 0
          @competition.longitude = 0
          @competition.save!
          post :search, :from => 'where I am now', :distance => '50'
        end

        it 'should give a 200 status code' do
          expect(response.status).to eq(200)
        end

        it 'should render the list Competition page' do
          expect(response).to render_template("index")
        end

        it 'should find one competition' do
          expect(assigns(:comps).length).to eq(1)
        end
      end
    end

    describe 'searching for competitions by date' do
      context 'only after a certain date' do
        before do
          post :search, :start_date => Date.today
        end

        it 'should give a 200 status code' do
          expect(response.status).to eq(200)
        end

        it 'should render the list Competition page' do
          expect(response).to render_template("index")
        end

        it 'should find one competition' do
          expect(assigns(:comps).length).to eq(1)
        end
      end
      context 'between two dates' do
        before do
          post :search, :start_date => Date.today + 3.days,
            :end_date => Date.today + 10.days
        end

        it 'should give a 200 status code' do
          expect(response.status).to eq(200)
        end

        it 'should render the list Competition page' do
          expect(response).to render_template("index")
        end

        it 'should find one competition' do
          expect(assigns(:comps).length).to eq(1)
        end
      end
    end

    describe 'deleting a competition' do
      before do
        Event.make!(:competition_id => @competition.id)
        delete :destroy, { :id => @competition.id }
      end

      it 'should redirect to the list Competition page' do
        expect(response).to redirect_to(competitions_path)
      end

      it 'should delete the Competition' do
        expect(Competition.count).to eq(0)
      end

      it 'should delete the Competition Events' do
        expect(Event.count).to eq(0)
      end
    end

    describe 'editing a competition' do
      before do
        get :edit, { :id => @competition.id }
      end

      it 'should set the @comp variable' do
        assigns(:comp).should eq(@competition)
      end
    end

    describe 'updating an edited competition' do
      before do
        valid_params = { :id => @competition.id, :competition =>
          {
            :name => 'Test2', :description => 'Updated', :events_attributes => {
              "0" => {
              :name => 'test event', :description => 'test event desc'
            }}
          }
        }
        patch :update, valid_params
      end

      it 'should update the Competition' do
        expect(Competition.count).to eq(1)
      end

      it 'should add the Event' do
        expect(Event.count).to eq(1)
      end

      it 'should set the Competition name' do
        expect(Competition.first.name).to eq("Test2")
      end

      it 'should redirect to the show Competition page' do
        expect(response).to redirect_to(competition_path(Competition.first.id))
      end

    end
    describe 'a list of attendess is requested' do
      before do
        @competition_attendee = 5.times {CompetitionAttendee.make!(
          :competition_id => @competition.id) }
        get :attendees, :competition_id => @competition.id
      end

      it 'should return status 200' do
        expect(response.status).to eq(200)
      end

      it 'should get a list of the attendees' do
        expect(assigns(:attendees).count).to eq(5)
      end

      it 'should render the attendee page' do
        expect(response).to render_template("attendees")
      end
    end
  end

  describe 'creating a new competition' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
    end

    it 'should give a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'should render the new Competition page' do
      expect(response).to render_template("new")
    end

  end

  describe 'saving a new competition' do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      file = fixture_file_upload('/empty.jpg','application/jpg')
      valid_params = { :competition =>
        {
          :name => 'Test', :description => 'Test competition',
          :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
          :image => file, :registration_close_date => 2.days.from_now,
          :location => 'a test location', :events_attributes => { "0" => {
            :name => 'test event', :description => 'test event desc'}
          }
        }
      }
      post :create, valid_params
    end

    it 'should create the Competition' do
      expect(Competition.count).to eq(1)
    end

    it 'should set the Competition user_id' do
      expect(Competition.first.user_id).to eq(@user.id)
    end

    it 'should add a CompetitionAdministrator' do
      expect(CompetitionAdministrator.count).to eq(1)
    end

    it 'should redirect to the show Competition page' do
      expect(response).to redirect_to(competition_path(Competition.first.id))
    end

  end
end
