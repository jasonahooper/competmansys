Given(/^that I am on the home page$/) do
  visit root_path
end

When(/^I follow "(.*?)"$/) do |followable|
  click_link followable
end

When(/^I click "(.*?)"$/) do |clickable|
  click_button clickable
end

Then(/^I will see the "(.*?)" page$/) do |page_content|
  assert page.find('h2').has_content?(page_content)
end

When(/^I fill in field "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, :with => value
end

Then(/^I will see "(.*?)"$/) do |page_content|
  assert page.has_content?(page_content)
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^debug$/) do
  binding.pry
end