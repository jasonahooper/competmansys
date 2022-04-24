require "spec_helper"

describe UserMailer do
  before do
    @user = User.make!
  end

  it "should queue the email" do
    ActionMailer::Base.deliveries.empty?.should be_falsey
  end
  it "should send the email to the new user" do
    ActionMailer::Base.deliveries.last.to.should eq([@user.email])
  end
  it "should have a subject of welcome" do
    ActionMailer::Base.deliveries.last.subject.should
      eq("Welcome to the Competition Management System")
  end
end
