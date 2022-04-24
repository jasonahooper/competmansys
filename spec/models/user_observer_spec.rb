require 'spec_helper'

describe UserObserver do
  before :each do
    @user = User.make
    @observer = UserObserver.instance
  end

  it "should invoke after_create on the observer" do
    expect(@observer).to receive(:after_create)
    @user.save!
  end
end
