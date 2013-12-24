Given(/^there is a competition named "(.*?)"$/) do |name|
  Competition.make!(:name => name)
end

Then(/^I will not see "(.*?)"$/) do |page_content|
  assert page.has_no_content?(page_content)
end

Given(/^there is a competition named "(.*?)" starting in "(.*?)" weeks from now$/) do
  |competition, weeks|
  Competition.make!(:name => competition, :start_date => Date.today + weeks.to_i.weeks)
end

Given(/^there is a competition named "(.*?)" located at "(.*?)" "(.*?)" latlong$/) do
  |competition, lat, lng|
  Competition.make!(:name => competition, :latitude => lat, :longitude => lng)
end

When(/^I fill in field "(.*?)" with "(.*?)" weeks from now$/) do |field, weeks|
  fill_in field, :with => Date.today + weeks.to_i.weeks
end
