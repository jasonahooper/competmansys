require 'spec_helper'

describe CompetitionAttendeesController do
  before do
    @user = User.make!(:competition_owner)
    @competition = Competition.make!(:user_id => @user.id)
    sign_in @user
  end

  describe 'a user indicates they will attend a competition' do
    before do
      post :create, :competition_id => @competition.id,
        :competition_attendee => { :user_id => @user.id}
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

    it 'should redirect to the list Competition page' do
      expect(response).to redirect_to(competition_path(@competition.id))
    end
  end

  describe 'a user indicates they will no longer attend a competition' do
    before do
      @competition_attendee = CompetitionAttendee.make!(
        :competition_id => @competition.id,
        :user_id => @user.id)
      delete :destroy, :competition_id => @competition.id,
        :id => @competition_attendee.id
    end

    it 'should delete the CompetitionAttendee' do
      expect(CompetitionAttendee.count).to eq(0)
    end

    it 'should redirect to the list Competition page' do
      expect(response).to redirect_to(competitions_path)
    end
  end
end
