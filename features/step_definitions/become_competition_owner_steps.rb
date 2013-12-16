When(/^I check "(.*?)"$/) do |checkbox|
  check checkbox
end

When(/^fill in my current password$/) do
  fill_in "Current password", :with => @user.password
end

Then(/^I will see "(.*?)" checked$/) do |checkbox|
  find(checkbox).should be_checked
end