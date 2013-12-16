Given(/^I have a user account with email "(.*?)" and password "(.*?)"$/) do |email, password|
  @user = User.make!(:email => email, :password => password)
end

Given(/^that I have a normal user account$/) do
  @user = User.make!
end

Given(/^that I have a "(.*?)" account$/) do |role|
  @user = User.make!
  role = role.downcase.gsub(' ','_')
  @user.roles = [role]
  @user.save!
end

Given(/^I am signed in$/) do
  visit root_path
  click_link "Login"
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
  click_button "Sign in"
end