require "spec_helper"

describe UserMailer do
  before do
    @user = User.make!
  end

  it "should queue the email" do
    expect(ActionMailer::Base.deliveries.empty?).to be_falsey
  end
  it "should send the email to the new user" do
    expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
  end
  it "should have a subject of welcome" do
    expect(ActionMailer::Base.deliveries.last.subject).
    to eq("Welcome to the Competition Management System")
  end
end
