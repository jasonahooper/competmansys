require 'spec_helper'

describe CompetitionsController do

  context 'with an existing competition' do
    before do
      @user = User.create!(:email => 'test@example.com', :password => 'password')
      @competition = Competition.create(
        :name => 'Test', :description => 'Test competition',
        :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
        :image => 'dummy.jpg', :registration_close_date => 2.days.from_now,
        :user_id => @user.id
      )
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

    describe 'editing a competition' do
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
        delete :destroy, { :id => @competition.id }
      end

      it 'should render the list Competition page' do
        expect(response).to redirect_to(competitions_path)
      end

      it 'should delete the Competition' do
        expect(Competition.count).to eq(0)
      end

    end
    describe 'updating an edited competition' do
      before do
        valid_params = { :id => @competition.id, :competition =>
          {
            :name => 'Test2', :description => 'Updated'
          }
        }
        patch :update, valid_params
      end

      it 'should update the Competition' do
        expect(Competition.count).to eq(1)
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

      valid_params = { :competition =>
        {
          :name => 'Test', :description => 'Test competition',
          :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
          :image => 'dummy.jpg', :registration_close_date => 2.days.from_now
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

    it 'should add a CompetitionAdministrator'
      # expect(CompetitionAdministrator.count).to eq(1)
    # end
    it 'should redirect to the show Competition page' do
      expect(response).to redirect_to(competition_path(Competition.first.id))
    end

  end
end
