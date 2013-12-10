require 'spec_helper'

describe UserObserver do
  before :each do
    @user = User.new(:email => "test@example.com", :password => "password")
    @observer = UserObserver.instance
  end

  it "should invoke after_create on the observer" do
    @observer.should_receive(:after_create)
    @user.save!
  end
end
