Given(/^there is a competition named "(.*?)"$/) do |name|
  Competition.make!(:name => name)
end

Then(/^I will not see "(.*?)"$/) do |page_content|
  assert page.has_no_content?(page_content)
end