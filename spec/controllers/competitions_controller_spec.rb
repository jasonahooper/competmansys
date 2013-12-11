require 'spec_helper'

describe CompetitionsController do

  describe 'creating a competition' do

    before do
      # @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create!(:email => 'test@example.com', :password => 'password')
      # sign_in user

      valid_params = { :competition =>
        {
          :name => 'Test', :description => 'Test competition',
            :start_date => 7.days.from_now, :end_date => 7.days.from_now + 7.days,
            :image => 'dummy.jpg', :registration_close_date => 2.days.from_now,
            :user_id => user.id
        }
      }
      post :create, valid_params
    end

    it 'should create the competition' do
      expect(Competition.count).to eq(1)
    end
  end
end
