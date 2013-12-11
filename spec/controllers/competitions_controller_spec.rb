require 'spec_helper'

describe CompetitionsController do

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
  end
end
