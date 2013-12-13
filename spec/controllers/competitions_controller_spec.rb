require 'spec_helper'

describe CompetitionsController do

  context 'with an existing competition' do
    before do
      @user = User.create!(:email => 'test@example.com', :password => 'password')
      file = fixture_file_upload('/sheffield.jpg','application/jpg')
      @competition = Competition.create(
        :name => 'Test', :description => 'Test competition',
        :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
        :image => file, :registration_close_date => 2.days.from_now,
        :user_id => @user.id, :location => 'a test location'
      )
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

    describe 'deleting a competition' do
      before do
        Event.create!(:competition_id => @competition.id, :name => 'Test Delete',
          :description => 'test delete')
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

  end

  describe 'creating a new competition' do
    before do
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
      @user = User.create!(:email => 'test@example.com', :password => 'password')
      sign_in @user

      file = fixture_file_upload('/sheffield.jpg','application/jpg')
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
