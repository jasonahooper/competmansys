When(/^I click on "(.*?)" in "(.*?)"$/) do |text, css|
  page.find(css, :text => text).click
end

Then(/^field "(.*?)" will be empty$/) do |field|
  find_field(field).value.should be_empty
end

Then(/^field "(.*?)" will contain "(.*?)"$/) do |field, text|
  find_field(field).value.should eq text
end
