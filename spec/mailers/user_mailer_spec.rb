require "spec_helper"

describe UserMailer do
  before do
    @user = User.new(:email => "test@example.com", :password => "password")
    @user.save!
  end

  it "should queue the email" do
    ActionMailer::Base.deliveries.empty?.should be_false
  end
  it "should send the email to the new user" do
    ActionMailer::Base.deliveries.last.to.should eq(["test@example.com"])
  end
  it "should have a subject of welcome" do
    ActionMailer::Base.deliveries.last.subject.should
      eq("Welcome to the Competition Management System")
  end
end
